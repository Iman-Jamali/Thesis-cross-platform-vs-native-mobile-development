class Todo {
  constructor(data) {
    this.id = data.id;
    this.title = data.title;
    this.description = data.description;
    this.updatedAt = new Date(data.updatedAt).toLocaleString("en-ca");
  }
}

export default Todo;
