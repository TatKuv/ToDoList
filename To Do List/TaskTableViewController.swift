
import UIKit

class TaskTableViewController: UITableViewController, TaskTableViewCellDelegate, UITextFieldDelegate  {
    
    var tasks = [Task (taskDescription: "Clean the pool"), Task (taskDescription: "Buy eggs", isDone: true)]
    var ActiveTFInCell : TaskTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.add))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.add))
        tableView.allowsSelection = false
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func changeRightBtn(_ cell: TaskTableViewCell, editing: Bool) {
        if editing {
            ActiveTFInCell = cell
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.save))
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.add))
        }
    }
    @objc private func save() {
        guard let cell = ActiveTFInCell else { return }
        let row = tableView.indexPath(for: cell)
        cell.taskTextField.resignFirstResponder()
        saveChanges(cell)
    }
    
    @objc private func add() {
        addNewTask(tasks.count)
        }
    
    func saveChanges (_ cell : TaskTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
              return
            }
        tasks[indexPath.row].taskDescription = cell.taskTextField.text ?? ""
    }
    
    func addNewTask (_ index: Int) {
        let newTask = Task (taskDescription: " ")
        tasks.insert(newTask, at: index)
        
        let newIndexPath = IndexPath(row: index, section: 0)
        self.tableView.insertRows(at: [newIndexPath], with: .automatic)
        let newCell: TaskTableViewCell = tableView.cellForRow(at: newIndexPath) as! TaskTableViewCell
        newCell.taskTextField.becomeFirstResponder()
    }
    
    func addTaskFromCell (_ cell: TaskTableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else {
              return
            }
        let index = indexPath.row + 1
        
        addNewTask(index)
        print("new task")
        
    }
    
    func doneStatus(_ cell: TaskTableViewCell, taskIsDone: Bool) {
        
        guard let indexPath = tableView.indexPath(for: cell) else {
              return
            }
        tasks[indexPath.row].isDone = taskIsDone
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell

        let object = tasks[indexPath.row]
        cell.setCells(object: object)
        print("hello")
        //cell.taskTextField.delegate = self
        cell.delegate = self
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        
//        let movedTask = tasks.remove(at: sourceIndexPath.row)
//        tasks.insert(movedTask, at: destinationIndexPath.row)
//        tableView.reloadData()
//    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteSwipe (at: indexPath)
        return UISwipeActionsConfiguration (actions: [delete])
    }

    func deleteSwipe (at indexPath: IndexPath) -> UIContextualAction {
//        var object = tasks[indexPath.row]
        let action = UIContextualAction(style: .normal , title: "Delete") { (action, view, completion) in
            self.tasks.remove(at: indexPath.row)
            self.tableView.deleteRows (at: [indexPath], with: .fade)
            completion (true)
        }
        action.backgroundColor = .systemRed
        return action
    }

    func deleteTask(_ cell: TaskTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        self.tasks.remove(at: indexPath.row)
        self.tableView.deleteRows (at: [indexPath], with: .fade)
       
    }
}
