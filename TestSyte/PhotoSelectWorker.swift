import UIKit

fileprivate protocol PhotoSelectorDelegate: class {
    func present(_ controller: UIViewController)
    func didSelect(_ image: UIImage)
}

fileprivate class PhotoSelector : NSObject {
    var delegate: PhotoSelectorDelegate?
    func showSelection() {
        
        let pickPhoto = UIAlertAction(title: "Choose Photo", style: .default) { (action) in
            self.pickImageFromPhotoLibrary()
        }
        
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { (action) in
            self.takePhoto()
        }
        
        let menu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        menu.addAction(takePhoto)
        menu.addAction(pickPhoto)
        menu.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        delegate?.present(menu)
    }
    deinit {
        print("Deinit \(NSStringFromClass(type(of: self)))")
    }
}

extension PhotoSelector: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var pickedImage : UIImage
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            pickedImage = image
        } else {
            pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage ?? UIImage()
        }
        
        picker.dismiss(animated: true, completion: nil)
        delegate?.didSelect(pickedImage)
    }
    
    func takePhoto() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        delegate?.present(imagePicker)
    }
    
    func pickImageFromPhotoLibrary() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        delegate?.present(imagePicker)
    }
}

class PhotoSelectorWorker {
    var successResponse : ((UIImage) -> Void)? = nil
    var selectedImage : UIImage?
    fileprivate var picker: PhotoSelector?
    
    init(finishSelection: ((UIImage) -> Void)?) {
        successResponse = finishSelection
    }
    
    func execute() {
        picker = PhotoSelector()
        picker?.delegate = self
        picker?.showSelection()
    }
}

extension PhotoSelectorWorker : PhotoSelectorDelegate {
    func present(_ controller: UIViewController) {
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.present(controller, animated: true)
        }
    }
    func didSelect(_ image: UIImage) {
        
        selectedImage = image
        successResponse?(image)
        picker = nil
    }
}
