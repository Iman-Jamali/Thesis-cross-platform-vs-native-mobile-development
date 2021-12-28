import Foundation

enum TodoError: Error {
    case noDataAvailable
    case cannotProcessData
    case encodingError
}

struct API {
    let resourceURL: URL
    
    init(endpoint: String) {
        let resourceString = "http://10.0.0.160:5000/\(endpoint)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    func getTodo(completion: @escaping(Result<Todo, TodoError>) -> Void) {
        URLSession.shared.dataTask(with: resourceURL) { (data, response, err) in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let todoResponse = try decoder.decode(Todo.self, from: jsonData)
                completion(.success(todoResponse))
                } catch {
                    completion(.failure(.cannotProcessData))
                }
            }.resume()
    }
    
    func postTodo(_ todo: Todo, completion: @escaping(Result<Message, TodoError>) -> Void) {
        do {
            var request = URLRequest(url: resourceURL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(todo)
            
            URLSession.shared.dataTask(with: request) { (data, response, err) in
                guard let jsonData = data else {
                    completion(.failure(.noDataAvailable))
                    return
                }
                do {
                    let todoResponse = try JSONDecoder().decode(Message.self, from: jsonData)
                    completion(.success(todoResponse))
                } catch {
                    completion(.failure(.cannotProcessData))
                }
            }.resume()
        } catch {
            completion(.failure(.encodingError))
        }
    }
    
    func patchTodo(_ todo: Todo, completion: @escaping(Result<Id, TodoError>) -> Void) {
        do {
            var request = URLRequest(url: resourceURL)
            request.httpMethod = "PATCH"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(todo)
            URLSession.shared.dataTask(with: request) { (data, response, err) in
                guard let jsonData = data else {
                    completion(.failure(.noDataAvailable))
                    return
                }
                do {
                    let todoResponse = try JSONDecoder().decode(Id.self, from: jsonData)
                    completion(.success(todoResponse))
                } catch {
                    completion(.failure(.cannotProcessData))
                }
            }.resume()
        } catch {
            completion(.failure(.encodingError))
        }
    }
    
    func deleteTodo(completion: @escaping(Result<Id, TodoError>) -> Void) {
            var request = URLRequest(url: resourceURL)
            request.httpMethod = "DELETE"
            URLSession.shared.dataTask(with: request) { (data, response, err) in
                guard let jsonData = data else {
                    completion(.failure(.noDataAvailable))
                    return
                }
                do {
                    let todoResponse = try JSONDecoder().decode(Id.self, from: jsonData)
                    completion(.success(todoResponse))
                } catch {
                    completion(.failure(.cannotProcessData))
                }
            }.resume()
        }
}
