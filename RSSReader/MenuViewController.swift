import UIKit
import CoreData

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var feedArray = [Feed]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }

    // MARK: - Table view data source
    
    @IBAction func addFeedButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add New Feed", message: "Enter feed name and url", preferredStyle: .alert)
            alert.addTextField { (textField: UITextField!) in
                textField.placeholder = "Feed name"
            }
            alert.addTextField { (textField:UITextField!) in
                textField.placeholder = "Feed url"
            }
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (alertAction: UIAlertAction!) in
                let textFields = alert.textFields
                let feedNameTextField = (textFields?.first)! as UITextField
                let feedUrlTextField = (textFields?.last)! as UITextField
                
                if feedNameTextField.text != "" && feedUrlTextField.text != "" {
                    let newItem = Feed(context: self.context)
                    newItem.name = feedNameTextField.text
                    newItem.url = feedUrlTextField.text
                    self.feedArray.append(newItem)
                    self.saveData()
                }
                
        }))
        present(alert, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        let item = feedArray[indexPath.row]
        cell.textLabel?.text = item.name
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newsController = storyboard.instantiateViewController(identifier: "NewsTableViewController") as! NewsTableViewController
        newsController.title = feedArray[indexPath.row].name
        newsController.url = feedArray[indexPath.row].url!
        navigationController?.pushViewController(newsController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        context.delete(feedArray[indexPath.row])
        feedArray.remove(at: indexPath.row)
        saveData()
    }
    
    
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let alert = UIAlertController(title: "Edit Feed", message: "Enter feed name and url", preferredStyle: .alert)
            alert.addTextField { (textField: UITextField!) in
                textField.placeholder = "Edit Feed name"
            }
            alert.addTextField { (textField:UITextField!) in
                textField.placeholder = "Edit Feed url"
            }
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (alertAction: UIAlertAction!) in
                let textFields = alert.textFields
                let feedNameTextField = (textFields?.first)! as UITextField
                let feedUrlTextField = (textFields?.last)! as UITextField
                
                self.feedArray[indexPath.row].setValue(feedNameTextField.text, forKey: "name")
                self.feedArray[indexPath.row].setValue(feedUrlTextField.text, forKey: "url")
                self.saveData()
                
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadData() {
        let request: NSFetchRequest<Feed> = Feed.fetchRequest()
        do {
            feedArray = try context.fetch(request)
        } catch {
            print("Error loading context \(error)")
        }
        tableView.reloadData()
    }

}
