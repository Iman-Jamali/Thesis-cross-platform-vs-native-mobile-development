import UIKit

class TodoTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
}

class TodoListTableViewController: UITableViewController {
    var data = [Todo]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Todo List"
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo))
        self.navigationItem.rightBarButtonItem = addBtn
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchTodos()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItem", for: indexPath) as! TodoTableViewCell
        let item = data[indexPath.row]
        cell.titleLabel?.text = item.title
        let inputDate = item.updatedAt
        let inputDf = DateFormatter()
        inputDf.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let date = inputDf.date(from:inputDate)!
        let outputDf = DateFormatter()
        outputDf.dateStyle = .medium
        outputDf.timeStyle = .medium
        outputDf.locale = Locale(identifier: "en_CA")
        cell.dateLabel?.text = outputDf.string(from: date)
        cell.descriptionLabel?.text = item.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let editTodoVC = storyBoard.instantiateViewController(identifier: "editTodo") as! EditTodoViewController
        let selectedTodoItem = data[indexPath[1]]
        editTodoVC.todoId = selectedTodoItem.id
        self.navigationController?.pushViewController(editTodoVC, animated: true)
    }    
    
    @objc func addTodo() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let editTodoVC = storyBoard.instantiateViewController(identifier: "editTodo") as! EditTodoViewController
        self.navigationController?.pushViewController(editTodoVC, animated: true)
    }
    
    func fetchTodos() -> Void {
        let api = API(endpoint: "todos")
        api.getTodos { [weak self] result in
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let todos):
                    let sortedTodos = todos.sorted {
                        return $0.updatedAt > $1.updatedAt
                    }
                    self?.data = sortedTodos
            }
        }
    }
}

