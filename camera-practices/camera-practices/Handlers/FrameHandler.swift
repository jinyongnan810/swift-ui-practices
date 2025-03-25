//
//  FrameHandler.swift
//  camera-practices
//
//  Created by Yuunan kin on 2025/03/24.
//

import AVFoundation
import CoreImage
import CoreImage.CIFilterBuiltins
import Observation
import SwiftUI
import Vision

@Observable
class FrameHandler: NSObject {
    var frame: CGImage?
    var backgroundImage: CGImage?

    var permissionGranted: Bool = false

    private let captureSession = AVCaptureSession()
    private let sessionQueue: DispatchQueue = .init(label: "sessionQueue")
    private let context: CIContext = .init()

    override init() {
        super.init()
        checkPermission()
        backgroundImage = UIImage(named: "tree")?.cgImage
    }

    func checkPermission() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            permissionGranted = true
        case .notDetermined:
            print("Not Determined")
            Task {
                await requestAccess()
            }
        default:
            permissionGranted = false
        }
    }

    func requestAccess() async {
        let isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
        permissionGranted = isAuthorized
    }

    func startCapturing() {
        print("⭐️ startCapturing")
        sessionQueue.async { [weak self] in
            guard let self else { return }
            setupCaptureSession()
            captureSession.startRunning()
        }
    }

    func setupCaptureSession() {
        guard permissionGranted else { return }
        let videoOutput = AVCaptureVideoDataOutput()

        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
            return
        }
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else {
            return
        }
        guard captureSession.canAddInput(videoDeviceInput) else {
            return
        }
        captureSession.sessionPreset = .vga640x480
        captureSession.addInput(videoDeviceInput)
        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.setSampleBufferDelegate(self, queue: sessionQueue)
        captureSession.addOutput(videoOutput)
        videoOutput.connection(with: .video)?.videoRotationAngle = 90
    }
}

extension FrameHandler: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(
        _: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from _: AVCaptureConnection
    ) {
        guard let cgImage = bufferToCGImage(sampleBuffer) else { return }
        DispatchQueue.main.async {
            self.frame = cgImage
        }
    }

    func bufferToCGImage(_ buffer: CMSampleBuffer) -> CGImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(buffer) else { return nil }
        let ciImage = CIImage(cvImageBuffer: imageBuffer)
        if backgroundImage != nil {
            return applyBackground(original: ciImage)
        } else {
            guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }
            return cgImage
        }
    }

    func applyBackground(original: CIImage) -> CGImage? {
        guard let backgroundImage else {
            return nil
        }
        let requestHandler = VNImageRequestHandler(ciImage: original)
        let request = VNGeneratePersonSegmentationRequest()
        do {
            // create mask
            try requestHandler.perform([request])
            if let buffer = request.results?.first {
                var maskImage = CIImage(cvPixelBuffer: buffer.pixelBuffer)
                // Scale mask to image size.
                let scaleX = original.extent.width / maskImage.extent.width
                let scaleY = original.extent.height / maskImage.extent.height
                maskImage = maskImage.transformed(by: .init(scaleX: scaleX, y: scaleY))

                let blendFilter = CIFilter.blendWithMask()
                blendFilter.inputImage = original
//                blendFilter.backgroundImage = CIImage(
//                    color: CIColor(color: .cyan)
//                )
//                .cropped(
//                    to: original.extent
//                )
                blendFilter.backgroundImage = CIImage(cgImage: backgroundImage)
                blendFilter.maskImage = maskImage
                let outputImage = blendFilter.outputImage
                return context.createCGImage(outputImage!, from: outputImage!.extent)!
            }
        } catch {
            print("⭐️ failed to generate mask: \(error)")
        }
        return nil
    }
}
