import UIKit

class resultViewController: UIViewController {
    var resultPhoto = UIImageView()
    var reStartButton = UIButton()
    var saveButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewHeight = view.bounds.height
        let viewWidth = view.bounds.width
        
        resultPhoto.frame = CGRect(x: 0,y: 0,width: viewWidth,height: viewHeight/2)
        resultPhoto.contentMode = .scaleAspectFit
        view.addSubview(resultPhoto)
        
        reStartButton.frame = CGRect(x: 0,y: viewHeight * 0.5,width: viewWidth,height: viewHeight*0.25)
        reStartButton.setTitle("Restart", for: .normal)
        reStartButton.titleLabel?.textColor = .white
        reStartButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 60)
        reStartButton.backgroundColor = UIColor(red: 75.0/255.0, green: 139.0/255, blue: 252/255, alpha: 1)
        reStartButton.addTarget(self, action: #selector(pushreStartButton), for: .touchDown)
        view.addSubview(reStartButton)
        
        saveButton.frame = CGRect(x: 0,y: viewHeight * 0.75,width: viewWidth,height: viewHeight*0.25)
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.textColor = .white
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 60)
        saveButton.backgroundColor = UIColor(red: 91.0/255.0, green: 178.0/255, blue: 78/255, alpha: 1)
        saveButton.addTarget(self, action: #selector(pushsaveButton), for: .touchDown)
        view.addSubview(saveButton)
    }
    
    @objc func pushreStartButton(sender: UIButton){
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "first") as! ViewController
        self.present(nextView, animated: true, completion:nil)
    }
    @objc func pushsaveButton(sender: UIButton){
        UIImageWriteToSavedPhotosAlbum(resultPhoto.image!, nil, nil, nil)
        let alert:UIAlertController = UIAlertController(title:"保存しました。",message: nil,preferredStyle: UIAlertControllerStyle.alert)
        let defaultAction:UIAlertAction = UIAlertAction(title: "OK",style: UIAlertActionStyle.default,handler:nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }

}
