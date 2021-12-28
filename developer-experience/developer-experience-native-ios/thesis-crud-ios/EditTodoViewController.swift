import UIKit

class EditTodoViewController: UIViewController {
    var todoId: String?
    var isEdit:Bool = false;
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var titleErrorLabel: UILabel!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var descriptionErrorLabel: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (todoId != nil) {
            isEdit = true;
            deleteBtn.isHidden = false;
        }
        
        self.title = isEdit ? "Edit Todo" : "Add Todo"
        editBtn.setTitle(isEdit ? "Update" : "Add", for: .normal)
        titleField.delegate = self
        descriptionField.delegate = self
        if isEdit {
            populateFields()
        }
    }
    
    func populateFields() {
        let api = API(endpoint: "todos/"+todoId!)
        api.getTodo(id: todoId! , completion: { [self] result in
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let todo):
                    DispatchQueue.main.async {
                        self.titleField.text = todo.title
                        self.descriptionField.text = todo.description
                    }
            }
        })
    }

    @IBAction func titleFieldChanged(_ sender: UITextField) {
        titleErrorLabel.text = ""
        titleErrorLabel.isHidden = true;
    }
    
    @IBAction func descriptionFieldChanged(_ sender: UITextField) {
        descriptionErrorLabel.text = ""
        descriptionErrorLabel.isHidden = true;
    }
    @IBAction func cancelBtnClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editClicked(_ sender: Any) {
        let titleStr: String = titleField.text!
        let descriptionStr: String = descriptionField.text!
        if (titleStr.isEmpty || descriptionStr.isEmpty) {
            if (titleStr.isEmpty) {
                titleErrorLabel.text = "Title is required!"
                titleErrorLabel.isHidden = false;
            }
            if (descriptionStr.isEmpty) {
                descriptionErrorLabel.text = "Description is required!"
                descriptionErrorLabel.isHidden = false;
            }
            return
        }
        let todo = Todo(id: "", title: titleStr, description: descriptionStr, updatedAt: "")
        if (isEdit) {
            let api = API(endpoint: "todos/"+todoId!)
            api.updateTodo(todo, completion: { result in
                            switch result {
                                case .failure(let error):
                                    print(error)
                                case .success(_):
                                    DispatchQueue.main.async {
                                        self.navigationController?.popViewController(animated: true)
                                }
                            }
                        })
        } else {
            let api = API(endpoint: "todos")
            api.addTodo(todo, completion: { result in
                            switch result {
                                case .failure(let error):
                                    print(error)
                                case .success(_):
                                    DispatchQueue.main.async {
                                        self.navigationController?.popViewController(animated: true)
                                }
                            }
                        })
        }
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        let api = API(endpoint: "todos/"+todoId!)
        api.deleteTodo { result in
            switch result {
                case .failure(let error):
                    print(error)
                case .success(_):
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
}

extension EditTodoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
