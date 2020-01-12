import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titileLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        titileLabel.text = RemoteConfigManager.shared.titleString
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.titileLabel.text = RemoteConfigManager.shared.titleString
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let storyboard: UIStoryboard = UIStoryboard.init(name: "CardRemoteConfigViewController", bundle: nil)
        let cardRemoteConfigViewController = storyboard.instantiateViewController(withIdentifier: "CardRemoteConfigViewController") as! CardRemoteConfigViewController
        cardRemoteConfigViewController.modalPresentationStyle = .fullScreen
        cardRemoteConfigViewController.setup()
        self.present(cardRemoteConfigViewController, animated: false, completion: nil)
    }
}
