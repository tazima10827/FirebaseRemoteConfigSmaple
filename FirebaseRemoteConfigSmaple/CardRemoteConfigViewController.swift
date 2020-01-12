import UIKit

class CardRemoteConfigViewController: UIViewController {
    @IBOutlet private weak var titleTextLabel: UILabel!
    @IBOutlet private weak var bodyTextView: UITextView!
    @IBOutlet private weak var presentWebButton: UIButton!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var cardImage: UIImageView!
    @IBOutlet private weak var modalView: UIView!

    func setup() {
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overCurrentContext
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        modalView.layer.cornerRadius = 8
        titleTextLabel.text = RemoteConfigManager.shared.cardRemoteConfig?.title
        bodyTextView.text = RemoteConfigManager.shared.cardRemoteConfig?.details
        if let url = RemoteConfigManager.shared.cardRemoteConfig?.imageURL?.convertURL {
            do {
                let data = try Data(contentsOf: url)
                cardImage.image = UIImage(data: data)
             }catch let err {
                  print("Error : \(err.localizedDescription)")
             }
        }
    }
    
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func presentWebButton(_ sender: Any) {
        if let openUrl = RemoteConfigManager.shared.cardRemoteConfig?.url.convertURL{
            if UIApplication.shared.canOpenURL(openUrl) {
                UIApplication.shared.open(openUrl)
            }
        }
    }
    
}

extension String{
    var convertURL: URL? {
        return URL(string: self)
    }
}
