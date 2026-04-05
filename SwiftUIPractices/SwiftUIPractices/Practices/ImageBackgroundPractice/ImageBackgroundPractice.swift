//
//  ImageBackgroundPractice.swift
//  SwiftUIPractices
//
//  Created by Codex on 2025/02/14.
//  Learning from Kavsoft: https://youtu.be/V7is79E2vhk?si=p1kgTrgTfThHhk7s
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI
import UIKit

struct ImageBackgroundPractice: View {
    private let imageNames: [String] = [
        "imgRoad",
        "imgNature",
        "imgPurpleLightening",
        "imgLightening1",
        "imgSunset2",
        "imgSunset1",
    ]

    @State private var currentIndex: Int = 0
    @State private var gradientColors: [Color] = [.black, .gray, .white]

    private var currentImageName: String {
        imageNames[currentIndex]
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: gradientColors,
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            Rectangle()
                .fill(.ultraThinMaterial.opacity(0.18))
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                Image(currentImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                    .overlay {
                        RoundedRectangle(cornerRadius: 32, style: .continuous)
                            .stroke(.white.opacity(0.28), lineWidth: 1)
                    }
                    .shadow(color: .black.opacity(0.22), radius: 30, y: 20)
                    .id(currentImageName)

                Text("Tap anywhere to show the next image")
                    .font(.headline)
                    .foregroundStyle(.white.opacity(0.92))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(.black.opacity(0.2), in: Capsule())

                Spacer()
            }
            .padding(24)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            showNextImage()
        }
        .task {
            updateGradientColors()
        }
    }

    private func showNextImage() {
        withAnimation(.easeInOut(duration: 0.45)) {
            currentIndex = (currentIndex + 1) % imageNames.count
            updateGradientColors()
        }
    }

    private func updateGradientColors() {
        gradientColors = Self.makeGradientColors(for: currentImageName)
    }

    private static func makeGradientColors(for imageName: String) -> [Color] {
        guard let image = UIImage(named: imageName),
              let resizedImage = image.resizedToWidth(200),
              let cgImage = resizedImage.cgImage
        else {
            return [.black, .gray, .white]
        }

        // Sample a smaller image first so average-color extraction stays cheap.
        let ciContext = CIContext(options: nil)
        let segmentHeight = max(cgImage.height / 3, 1)

        return (0 ..< 3).map { index in
            let originY = min(index * segmentHeight, max(cgImage.height - 1, 0))
            let height: Int = if index == 2 {
                cgImage.height - originY
            } else {
                segmentHeight
            }

            let cropRect = CGRect(
                x: 0,
                y: originY,
                width: cgImage.width,
                height: max(height, 1)
            )

            // Split the resized image into top, middle, and bottom thirds.
            guard let croppedImage = cgImage.cropping(to: cropRect) else {
                return .clear
            }

            return averageColor(for: croppedImage, context: ciContext)
        }
    }

    private static func averageColor(for cgImage: CGImage, context: CIContext) -> Color {
        let inputImage = CIImage(cgImage: cgImage)
        let filter = CIFilter.areaAverage()
        filter.inputImage = inputImage
        filter.extent = inputImage.extent

        guard let outputImage = filter.outputImage else {
            return .clear
        }

        // CIAreaAverage reduces the full region into a single 1x1 representative color.
        var bitmap = [UInt8](repeating: 0, count: 4)
        context.render(
            outputImage,
            toBitmap: &bitmap,
            rowBytes: 4,
            bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
            format: .RGBA8,
            colorSpace: CGColorSpaceCreateDeviceRGB()
        )

        return Color(
            red: Double(bitmap[0]) / 255,
            green: Double(bitmap[1]) / 255,
            blue: Double(bitmap[2]) / 255
        )
    }
}

private extension UIImage {
    func resizedToWidth(_ width: CGFloat) -> UIImage? {
        guard size.width > 0, size.height > 0 else { return nil }

        let ratio = width / size.width
        let targetSize = CGSize(width: width, height: size.height * ratio)
        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            // UIGraphicsImageRenderer gives us a quick UIKit resize pass before analysis.
            draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}

#Preview {
    ImageBackgroundPractice()
}
