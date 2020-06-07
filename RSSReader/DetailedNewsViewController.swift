
import UIKit

class DetailedNewsViewController: UIViewController {

    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var newsDescription: UITextView!
    
    var newsTitle = ""
    var newsDate = ""
    var newsDescriptions = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        newsTitleLabel.text = newsTitle
        newsDateLabel.text = newsDate
        newsDescription.text = newsDescriptions
    }

}
