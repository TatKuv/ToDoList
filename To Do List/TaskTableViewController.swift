
import UIKit

class TaskTableViewController: UITableViewController, TaskTableViewCellDelegate  {
    
    var tasks = [Task (taskDescription: "Clean the pool"), Task (taskDescription: "Buy eggs", isDone: true)]
    
    @IBAction func doneOrAdd(_ sender: UIBarButtonItem) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    func addNewTask (_ cell: TaskTableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else {
              return
            }
        let newTask = Task (taskDescription: " ")
        tasks.insert(newTask, at: indexPath.row + 1)
        
        let newIndexPath = IndexPath(row: indexPath.row + 1, section: 0)
        self.tableView.insertRows(at: [newIndexPath], with: .automatic)
        let newCell: TaskTableViewCell = tableView.cellForRow(at: newIndexPath) as! TaskTableViewCell
        newCell.taskTextField.becomeFirstResponder()
        //self.tableView.reloadData()
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
