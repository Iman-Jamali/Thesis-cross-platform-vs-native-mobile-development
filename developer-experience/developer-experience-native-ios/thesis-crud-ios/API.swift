import Foundation

enum TodoError: Error {
    case noDataAvailable
    case cannotProcessData
    case encodingError
}

struct API {
    let resourceURL: URL
    
    init(endpoint: String) {
        let resourceString = "http://10.0.0.160:5000/api/v1/\(endpoint)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    func getTodos(completion: @escaping(Result<[Todo], TodoError>) -> Void) {
        URLSession.shared.dataTask(with: resourceURL) { (data, response, err) in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let todosResponse = try JSONDecoder().decode([Todo].self, from: jsonData)
                completion(.success(todosResponse))
                } catch {
                    completion(.failure(.cannotProcessData))
                }
            }.resume()
    }
    
    func getTodo(id: String, completion: @escaping(Result<Todo, TodoError>) -> Void) {
        URLSession.shared.dataTask(with: resourceURL) { (data, response, err) in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let todoResponse = try
                    JSONDecoder().decode(Todo.self, from: jsonData)
                completion(.success(todoResponse))
                } catch {
                    completion(.failure(.cannotProcessData))
                }
            }.resume()
    }
    
    func addTodo(_ todo: Todo, completion: @escaping(Result<String, TodoError>) -> Void) {
        do {
            var request = URLRequest(url: resourceURL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(todo)
            
            URLSession.shared.dataTask(with: request) { (data, response, err) in
                if err != nil {
                    completion(.failure(.cannotProcessData))
                }
                completion(.success("Added successfully"))
            }.resume()
            
        } catch {
            completion(.failure(.encodingError))
        }
    }
    
    func updateTodo(_ todo: Todo, completion: @escaping(Result<String, TodoError>) -> Void) {
        do {
            var request = URLRequest(url: resourceURL)
            request.httpMethod = "PATCH"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(todo)
            URLSession.shared.dataTask(with: request) { (data, response, err) in
                if err != nil {
                    completion(.failure(.cannotProcessData))
                }
                completion(.success("Updated successfully"))
            }.resume()
        } catch {
            completion(.failure(.encodingError))
        }
    }
    
    func deleteTodo(completion: @escaping(Result<String, TodoError>) -> Void) {
            var request = URLRequest(url: resourceURL)
            request.httpMethod = "DELETE"
            URLSession.shared.dataTask(with: request) { (data, response, err) in
                if err != nil {
                    completion(.failure(.cannotProcessData))
                }
                completion(.success("Deleted successfully"))
            }.resume()
        }
}
