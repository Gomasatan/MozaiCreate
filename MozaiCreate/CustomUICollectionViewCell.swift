import UIKit

class CustomUICollectionViewCell: UICollectionViewCell {
    var  image = UIImageView()
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        image = UIImageView(frame: CGRect(x:0, y:0, width:frame.width, height:frame.height))
        image.backgroundColor = UIColor.clear
        self.contentView.addSubview(image)
    }
    

}
