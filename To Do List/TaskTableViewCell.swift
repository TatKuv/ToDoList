import UIKit

class TaskTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var taskTextField: UITextField!
    
    @IBOutlet weak var taskCheckBox: UIButton!
    
    @IBAction func taskCheckBox(_ sender: UIButton) {
        
        setButton(button: sender)

    }
    
    func setButton(button: UIButton) {
        if button.currentImage == UIImage(systemName: "square") {
            button.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            }
            else {
                button.setImage( UIImage(systemName: "square"), for: .normal)
            }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setButton(button: taskCheckBox)
        self.taskTextField.delegate = self
    }
    
    
    func textFieldShouldReturn(taskTextField: UITextField) -> Bool {

            taskTextField.resignFirstResponder()
            performAction()
            return true
        }

        func performAction() {
            let addTask = TaskTableViewController()
            addTask.addNewTask()
            
        }
    

    func setCells (object : Task){
        
        self.taskTextField.text = object.taskDescription
        
//        if object.isDone {
//            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "Your Text")
//                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
//            taskTextField.attributedText = attributeString
//        }
//        else {}
       
    }

}
