import UIKit

class imageProcessViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    let mozaicpx = 50
    let pixcel = 5
    var redArray:[CGFloat] = []
    var blueArray:[CGFloat] = []
    var greenArray:[CGFloat] = []
    
    var xCount = 0
    var yCount = 0
    var colorFlag = 0
    var usePhoto = 0
    let myDictionary = [
        "janken" : [UIImage(named : "g.png"),UIImage(named : "c.png"),UIImage(named : "p.png")],
        "puzzle":[UIImage(named : "sample1.png"),UIImage(named : "sample2.png"),UIImage(named : "sample3.png")],
        "balloon":[UIImage(named : "sample4.png"),UIImage(named : "sample5.png"),UIImage(named : "sample6.png")],
        "fruit":[UIImage(named : "sample7.png"),UIImage(named : "sample8.png"),UIImage(named : "sample9.png")],
        "flower":[UIImage(named : "sample10.png"),UIImage(named : "sample11.png"),UIImage(named : "sample12.png"),UIImage(named : "sample13.png")],
        "heart":[UIImage(named : "sample14.png"),UIImage(named : "sample15.png")],
        "card":[UIImage(named : "sample16.png")],
        "food":[UIImage(named : "sample18.png"),UIImage(named : "sample19.png"),UIImage(named : "sample20.png"),UIImage(named : "sample21.png"),UIImage(named : "sample22.png")],
        "animal":[UIImage(named : "sample23.png"),UIImage(named : "sample24.png"),UIImage(named : "sample25.png"),UIImage(named : "sample26.png"),UIImage(named : "sample27.png"),UIImage(named : "sample28.png")],
        "ball":[UIImage(named : "sample29.png"),UIImage(named : "sample30.png"),UIImage(named : "sample31.png"),UIImage(named : "sample32.png"),UIImage(named : "sample33.png")],
        "sea":[UIImage(named : "sample34.png"),UIImage(named : "sample35.png"),UIImage(named : "sample36.png"),UIImage(named : "sample37.png"),UIImage(named : "sample38.png"),UIImage(named : "sample39.png")]]
    
    let icon = [UIImage(named : "icon12"),UIImage(named : "icon7"),UIImage(named : "icon11.png"),UIImage(named : "icon8.png"),UIImage(named : "icon6.png"),UIImage(named : "icon10.png"),UIImage(named : "icon5.png"),UIImage(named : "icon2.png"),UIImage(named : "icon4.png"),UIImage(named : "icon1.png"),UIImage(named : "icon3.png")]
    
    let keyArray = ["janken","puzzle","balloon","fruit","flower","heart","card","food","animal","ball","sea"]
    
    var cellColor = [Bool](repeating: false, count: 11)
    
    var tookPhotoView = UIImageView()
    var CreateButton = UIButton()
    var selectImageCollectionView: UICollectionView!
    var usePhotoImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewHeight = view.bounds.height
        let viewWidth = view.bounds.width
        let itemCellSize = viewHeight*0.15 - 20.0
        
        tookPhotoView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight*0.6
        )
        tookPhotoView.contentMode = .scaleAspectFit
        view.addSubview(tookPhotoView)
        
        CreateButton.frame = CGRect(x: 0, y: viewHeight * 0.6, width: viewWidth, height: viewHeight*0.25)
        CreateButton.setTitle("Create", for: .normal)
        CreateButton.titleLabel?.textColor = .white
        CreateButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 60)
        CreateButton.backgroundColor = UIColor(red: 75.0/255.0, green: 139.0/255, blue: 252/255, alpha: 1)
        CreateButton.addTarget(self, action: #selector(pushCreateButton), for: .touchDown)
        view.addSubview(CreateButton)
        
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:itemCellSize, height:itemCellSize)
        layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20)
        layout.scrollDirection = .horizontal
        
        selectImageCollectionView = UICollectionView(frame: CGRect(x:0, y:viewHeight*0.85, width:viewWidth, height:viewHeight*0.15), collectionViewLayout: layout)
        selectImageCollectionView.backgroundColor = UIColor(red: 51 / 255, green: 51 / 255, blue: 76 / 255, alpha: 1)
        selectImageCollectionView.register(CustomUICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        selectImageCollectionView.delegate = self
        selectImageCollectionView.dataSource = self
        view.addSubview(selectImageCollectionView)
    }
    //画像のリサイズ
    func resizeImage(image: UIImage, width: CGFloat) -> UIImage {
        let ratioSize = image.size.height / image.size.width
        UIGraphicsBeginImageContext(CGSize(width: width, height: width * ratioSize))
        image.draw(in: CGRect(x: 0, y: 0,width: width, height: width * ratioSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
    //フィルタリング
    func filtering (photo : CIImage)->UIImage{
        let filter = CIFilter(name: "CIPixellate")
        filter?.setValue(photo, forKey: kCIInputImageKey)
        filter?.setValue(pixcel, forKey: "inputScale")
        let filteredImage:CIImage = (filter?.outputImage)!
        let ciContext:CIContext = CIContext(options: nil)
        let imageRef = ciContext.createCGImage(filteredImage, from: filteredImage.extent)
        let outputImage = UIImage(cgImage:imageRef!, scale:1.0, orientation:UIImageOrientation.up)
        return outputImage
    }
    
    //画像の色の取得
    func findrgb(photo: UIImage){
        let pixelsWide = Int(photo.size.width)
        let pixelsHigh = Int(photo.size.height)
        let pixelData = (photo).cgImage?.dataProvider?.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        for y in 1..<pixelsHigh/pixcel {
            yCount += 1
            for x in 1..<pixelsWide/pixcel{
                xCount += 1
                let point = CGPoint(x: x*pixcel, y: y*pixcel)
                let pixelInfo: Int = ((pixelsWide * Int(point.y)) + Int(point.x)) * 4
                let red = CGFloat(data[pixelInfo])
                let blue = CGFloat(data[pixelInfo+2])
                let green = CGFloat(data[pixelInfo+1])
                redArray.append(red)
                blueArray.append(blue)
                greenArray.append(green)
            }
        }
    }
    
    func imagemake()->UIImage{
        
        UIGraphicsBeginImageContext(CGSize(width: xCount/yCount * mozaicpx, height: yCount * mozaicpx))
        var colorNum = 0
        for y in 0..<yCount{
            for x in 0..<xCount/yCount{
                makeView(colorIndex: colorNum).draw(in: CGRect(x: x * mozaicpx , y: y * mozaicpx, width: mozaicpx, height: mozaicpx))
                myDictionary[keyArray[usePhoto]]![Int(arc4random_uniform(UInt32(myDictionary[keyArray[usePhoto]]!.count)))]?.draw(in: CGRect(x: x * mozaicpx, y: y * mozaicpx, width: mozaicpx, height: mozaicpx))
                colorNum += 1
            }
        }
        //context上に合成された画像を得る
        let compositedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return compositedImage!
    }
    
    func makeView(colorIndex:Int)->UIImage{
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: mozaicpx, height: mozaicpx))
        myView.backgroundColor = UIColor(red: (redArray[colorIndex]/255.0), green: (greenArray[colorIndex]/255.0), blue: (blueArray[colorIndex]/255.0), alpha: 1)
        return getUIImageFromUIView(myUIView: myView)
    }
    func getUIImageFromUIView(myUIView:UIView) ->UIImage{
        UIGraphicsBeginImageContextWithOptions(myUIView.frame.size, true, 0)//必要なサイズ確保
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.translateBy(x: -myUIView.frame.origin.x, y: -myUIView.frame.origin.y)
        myUIView.layer.render(in: context)
        let renderedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return renderedImage
    }
    func MoveToResult(photo:UIImage){
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "result") as! resultViewController
        self.present(nextView, animated: true, completion:{nextView.resultPhoto.image = photo})
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath) != nil {
            cellColor[indexPath.row] = true
            usePhoto = indexPath.row
            selectImageCollectionView.reloadData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : CustomUICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CustomUICollectionViewCell
        cell.image.image = icon[indexPath.row]
        if (cellColor[indexPath.row]){
            cell.contentView.backgroundColor = .gray
            cellColor[indexPath.row] = false
        }else{
            cell.contentView.backgroundColor = .clear
        }
        return cell
    }
    
    @objc func pushCreateButton(sender: UIButton){
        findrgb(photo: filtering(photo: CIImage(image: resizeImage(image: tookPhotoView.image!, width: 400))!))
        MoveToResult(photo: imagemake())
    }
}
