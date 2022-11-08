import UIKit


protocol TaskTableViewCellDelegate: AnyObject {
    func addTaskFromCell (_ cell: TaskTableViewCell)
    func doneStatus (_ cell : TaskTableViewCell, taskIsDone: Bool)
    func deleteTask (_ cell: TaskTableViewCell)
    func saveChanges (_ cell: TaskTableViewCell)
    func changeRightBtn ( _ cell: TaskTableViewCell, editing : Bool)
}




class TaskTableViewCell: UITableViewCell, UITextFieldDelegate {
    
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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        taskTextField.delegate = self
    }
    

    func textFieldShouldReturn(_ taskTextField: UITextField) -> Bool {
        print("Enter")
        //taskTextField.resignFirstResponder()
        guard !(taskTextField.text?.isEmpty ?? true) else {
            delegate?.deleteTask(self);
            return true}
        delegate?.saveChanges(self)
        delegate?.addTaskFromCell(self)
        return true
    }
    
    
    func setCells (object : Task){
        self.taskTextField.text = object.taskDescription
        self.TaskIsDone = object.isDone
        setButton(button: taskCheckBox)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("begin")
        let isActive = true
        delegate?.changeRightBtn(self,editing: isActive)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isActive = false
        delegate?.changeRightBtn(self,editing: isActive)
    }
}
 
