import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIViewControllerTransitioningDelegate{
    
    var sampleView = UIImageView()
    var cameraButton = UIButton()
    var photoGalleryButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewHeight = view.bounds.height
        let viewWidth = view.bounds.width
        
        sampleView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight/2)
        sampleView.image = UIImage(named: "sampleImage.jpg")
        view.addSubview(sampleView)
        
        cameraButton.frame = CGRect(x: 0, y: viewHeight * 0.5, width: viewWidth, height: viewHeight/4)
        cameraButton.setImage(UIImage(named: "camera.png"), for: .normal)
        cameraButton.setTitle("    Camera    ", for: .normal)
        cameraButton.titleLabel?.textColor = .white
        cameraButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        cameraButton.backgroundColor = UIColor(red: 75.0/255.0, green: 139.0/255, blue: 252/255, alpha: 1)
        cameraButton.addTarget(self, action: #selector(pushCameraButton), for: .touchDown)
        view.addSubview(cameraButton)
        
        photoGalleryButton.frame = CGRect(x: 0, y: viewHeight * 0.75, width: viewWidth, height: viewHeight/4)
        photoGalleryButton.setImage(UIImage(named: "photoGallery.png"), for: .normal)
        photoGalleryButton.setTitle("PhotoGallery", for: .normal)
        photoGalleryButton.titleLabel?.textColor = .white
        photoGalleryButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 36)
        photoGalleryButton.backgroundColor = UIColor(red: 91.0/255.0, green: 178.0/255, blue: 78/255, alpha: 1)
        photoGalleryButton.addTarget(self, action: #selector(pushPhotoGalleryButton), for: .touchDown)
        view.addSubview(photoGalleryButton)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion:{
            let nextView = self.storyboard!.instantiateViewController(withIdentifier: "process") as! imageProcessViewController
            self.present(nextView, animated: true, completion: {
                nextView.tookPhotoView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            })
        })
    }
    
    @objc func pushCameraButton(sender: UIButton){
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @objc func pushPhotoGalleryButton(sender: UIButton){
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
}
