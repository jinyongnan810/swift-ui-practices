//
//  FrameHandler.swift
//  camera-practices
//
//  Created by Yuunan kin on 2025/03/24.
//

import AVFoundation
import CoreImage
import Observation

@Observable
class FrameHandler: NSObject {
    var frame: CGImage?

    var permissionGranted: Bool = false

    private let captureSession = AVCaptureSession()
    private let sessionQueue: DispatchQueue = .init(label: "sessionQueue")
    private let context: CIContext = .init()

    override init() {
        super.init()
        checkPermission()
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
        captureSession.addInput(videoDeviceInput)

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
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }
        return cgImage
    }
}
