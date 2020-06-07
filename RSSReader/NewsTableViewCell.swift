import UIKit

enum CellState {
    case expanded
    case collapsed
}

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel:UILabel!

    var item: RSSItem! {
        didSet {
            titleLabel.text = item.title
        }
    }
}












