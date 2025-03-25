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

enum Mode: String, CaseIterable {
    case color, image, blur, none
}

@Observable
class FrameHandler: NSObject {
    var frame: CGImage?
    var backgroundImage: CGImage?
    var mode: Mode = .image

    var permissionGranted: Bool = false

    private let captureSession = AVCaptureSession()
    private let sessionQueue: DispatchQueue = .init(label: "sessionQueue")
    private let context: CIContext = .init()

    override init() {
        super.init()
        checkPermission()
        if let originalImage = UIImage(named: "tree")?.cgImage {
            backgroundImage = resizeImage(originalImage, width: 480, height: 640)
        }
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

    func resizeImage(_ image: CGImage, width: Int, height: Int) -> CGImage? {
        let ciImage = CIImage(cgImage: image)
        let scaleX = CGFloat(width) / ciImage.extent.width
        let scaleY = CGFloat(height) / ciImage.extent.height
        let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        let resizedImage = ciImage.transformed(by: transform)

        return context.createCGImage(resizedImage, from: CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))
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
        return applyBackground(original: ciImage)
    }

    func applyBackground(original: CIImage) -> CGImage? {
        if mode == .none {
            guard let cgImage = context.createCGImage(original, from: original.extent) else { return nil }
            return cgImage
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
                switch mode {
                case .blur:
                    blendFilter.backgroundImage = blurImage(original)
                case .image:
                    guard let backgroundImage else { return nil }
                    blendFilter.backgroundImage = CIImage(cgImage: backgroundImage)
                case .color:
                    blendFilter.backgroundImage = CIImage(
                        color: CIColor(color: .cyan)
                    )
                    .cropped(
                        to: original.extent
                    )
                default:
                    blendFilter.backgroundImage = CIImage(
                        color: CIColor(color: .cyan)
                    )
                    .cropped(
                        to: original.extent
                    )
                }

                blendFilter.maskImage = maskImage
                let outputImage = blendFilter.outputImage
                return context.createCGImage(outputImage!, from: outputImage!.extent)!
            }
        } catch {
            print("⭐️ failed to generate mask: \(error)")
        }
        return nil
    }

    func blurImage(_ image: CIImage) -> CIImage {
        image
            .clampedToExtent()
            .applyingFilter("CIGaussianBlur", parameters: ["inputRadius": 10])
            .cropped(to: image.extent)
    }
}
