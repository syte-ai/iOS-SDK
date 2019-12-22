import UIKit
import Syte

class ViewController: UITableViewController {
    let syte = SyteAI(accountID: "7300", token: "5ca6690b445ef77f87d3bbd5")
    var offerDetails = [OfferDetails]()
    var bounds = [ImageBounds]()
    @IBOutlet weak var offerCountLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var linkTextField: UITextField!
    
    @objc func getOffer(sender: UIButton) {
        self.syte.getOffers(url: bounds[sender.tag].offers!, success: { (offerDetail) in
            DispatchQueue.main.async() {
                var text = "------Bound \(sender.tag + 1) Offers - Ads count: \(offerDetail.ads.count)---------\n"
                if offerDetail.ads.isEmpty { return }
                text += offerDetail.ads[0].getFullDescription()
                self.detailTextView.text = text
            }
        }, fail: { err in
            print(err)
        })
    }
    
    @IBAction func getBoundsFromLink(_ sender: Any) {
        syte.getBoundsForImage(fromUrl: linkTextField.text!,
                               feed: "general",
                               success: { (bounds) in
                                DispatchQueue.main.async() {
                                    self.downloadImage(from: self.linkTextField.text!, to: self.imageView)
                                    self.bounds = bounds
                                }
                                
        }, fail: { error in
            print(error)
        })
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        PhotoSelectorWorker { (image) in
            self.imageView.image = image
            self.syte.getBoundsForImage(image: image, feed: "general",
                                   success: { (bounds) in
                                    DispatchQueue.main.async() {
                                        self.bounds = bounds
                                    }
                                    
            }, fail: { error in
                print(error)
            })
        }.execute()
    }
    
    @IBAction func retrieveBounds(_ sender: Any) {
        DispatchQueue.main.async() {
            self.showBoundButton()
            self.offerCountLabel.text = "Bounds: \(self.bounds.count)"
        }
    }
    
    func showBoundButton() {
        for i in 0 ..< bounds.count {
            let button = UIButton()
            button.setTitleColor(.blue, for: .normal)
            button.setTitle("Bound \(i + 1)", for: .normal)
            button.tag = i
            button.addTarget(self, action: #selector(getOffer), for: .touchUpInside)
            buttonsStackView.addArrangedSubview(button)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var config = Config()
        config.catalog = Config.Catalog.default
        config.currency = "ILS"
        config.gender = .male
        syte.modifyConfig(config: config)
        
        linkTextField.text = "http://wearesyte.com/syte_docs/images/1.jpeg"
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewOffer)))
    }
    
    @objc func viewOffer() {
        for offer in offerDetails {
            detailTextView.text += "\n--------------\n"
            detailTextView.text += offer.ads.first!.getFullDescription()
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from link: String, to imageView: UIImageView) {
        guard let url = URL(string: link) else { return }
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                imageView.image = UIImage(data: data)
            }
        }
    }
}

