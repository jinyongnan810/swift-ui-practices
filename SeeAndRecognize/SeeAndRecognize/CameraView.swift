import SwiftUI
import UIKit

struct CameraView: UIViewControllerRepresentable {
    @Binding var isShown: Bool
    @Binding var image: Image?
    @Binding var result: String

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: CameraView

        init(parent: CameraView) {
            self.parent = parent
        }

        func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = Image(uiImage: uiImage)
                parent.result = "Processing..."
                let result = processImage(uiImage)
                if let result {
                    parent.result = result
                } else {
                    parent.result = "Couldn't process image"
                }
            }
            parent.isShown = false
        }

        func imagePickerControllerDidCancel(_: UIImagePickerController) {
            parent.isShown = false
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
//        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_: UIImagePickerController, context _: UIViewControllerRepresentableContext<CameraView>) {}
}
