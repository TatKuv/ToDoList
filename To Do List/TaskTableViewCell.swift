import UIKit


protocol TaskTableViewCellDelegate: AnyObject {
  //func checkTableViewCell(_ cell: TaskTableViewCell, didChagneCheckedState checked: Bool)
    func addNewTask (_ cell: TaskTableViewCell, task: String)
    func doneStatus (_ cell : TaskTableViewCell, taskIsDone: Bool)
    
}




class TaskTableViewCell: UITableViewCell {
    
    weak var delegate: TaskTableViewCellDelegate?
    
    
    private var TaskIsDone = false
    
    @IBOutlet weak var taskTextField: UITextField!
    
    @IBOutlet weak var taskCheckBox: UIButton!
    
    @IBAction func taskCheckBox(_ sender: UIButton) {
        TaskIsDone = !TaskIsDone
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
        delegate?.doneStatus(self, taskIsDone: TaskIsDone)
        taskTextField.attributedText = attributedString
    }
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        setButton(button: taskCheckBox)
//        self.taskTextField.delegate = self
//    taskTextField.delegate = self
//    }
    

    func textFieldShouldReturn(_ taskTextField: UITextField) -> Bool {
        
        print("Enter")
        taskTextField.resignFirstResponder()
        performAction()
        return true
    }
    
    func performAction() {
        print("here i am")
        delegate?.addNewTask(self, task: "Something else")
        
    }
    
    
    func setCells (object : Task){
        
        self.taskTextField.text = object.taskDescription
        self.TaskIsDone = object.isDone
        setButton(button: taskCheckBox)
    }
    
}
 
