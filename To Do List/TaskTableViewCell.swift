import UIKit

class TaskTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    var newTask : UITableViewController?
    
    private var TaskIsDone = false
    
    @IBOutlet weak var taskTextField: UITextField!
    
    @IBOutlet weak var taskCheckBox: UIButton!
    
    @IBAction func taskCheckBox(_ sender: UIButton) {
        
        setButton(button: sender)
        
    }
    
    func setButton(button: UIButton) {
        let attributedString = NSMutableAttributedString(string: taskTextField.text!)
        
        if TaskIsDone {
            //button.currentImage == UIImage(systemName: "square")
            button.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            attributedString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length-1))
            
        } else {
            button.setImage( UIImage(systemName: "square"), for: .normal)
            attributedString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributedString.length-1))
        }
        TaskIsDone = !TaskIsDone
        taskTextField.attributedText = attributedString
    }
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        setButton(button: taskCheckBox)
//        //self.taskTextField.delegate = self
//    }
    

//    func textFieldShouldReturn(taskTextField: UITextField) -> Bool {
//        
//        print("Enter")
//        taskTextField.resignFirstResponder()
//        performAction()
//        return true
//    }
//    
//    func performAction() {
//        print("here i am")
//        let addTask = TaskTableViewController()
//        addTask.addNewTask()
//        
//    }
    
    
    func setCells (object : Task){
        
        self.taskTextField.text = object.taskDescription
        self.TaskIsDone = object.isDone
        setButton(button: taskCheckBox)
    }
    
}
