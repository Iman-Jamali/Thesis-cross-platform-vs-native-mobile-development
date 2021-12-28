//
//  ViewController.swift
//  resource native
//
//  Created by Iman Jamali on 2021-10-02.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func testAPressed() {
        let startTime = NSDate().timeIntervalSince1970 * 1000
        _ = findPrimes(maxNum: 300000)
        let endTime = NSDate().timeIntervalSince1970 * 1000
        print("Test A duration", endTime - startTime)
    }
    
    @IBAction func testBPressed() {
        let startTime = NSDate().timeIntervalSince1970 * 1000
        let min = 0
        let max = 1
        let n = 400
        let m = 200000
        var graph = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
        for i in 0..<m {
            var v = Array(repeating: 0, count: n)
            for j in 0..<n {
                let randomNum = Int.random(in: min...max)
                v[j] = randomNum
            }
            graph[i] = v;
        }
        transitiveClosure(graph: graph, V: n);
        let endTime = NSDate().timeIntervalSince1970 * 1000
        print("Test B duration", endTime - startTime)
    }
        
    @IBAction func TestCPressed() {
        let startTime = NSDate().timeIntervalSince1970 * 1000
        let dispatchGroup = DispatchGroup()
        let newTodoItem = Todo(id: "1", title: "t", description: "d")
        let postApi = API(endpoint: "todos")
        let getPatchDeleteApi = API(endpoint: "todos/\(newTodoItem.id)")
        let n = 500

        for _ in 0..<n {
            dispatchGroup.enter()
            getPatchDeleteApi.getTodo { [weak self] result in
                switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let todo):
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.enter()
            postApi.postTodo(newTodoItem, completion: { result in
                switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let message):
                        dispatchGroup.leave()
                    }
                })
            
            
            dispatchGroup.enter()
            getPatchDeleteApi.patchTodo(newTodoItem, completion: { result in
                switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let id):
                        dispatchGroup.leave()
                    }
                })
            
            
            dispatchGroup.enter()
            getPatchDeleteApi.deleteTodo(completion: { result in
                switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let id):
                        dispatchGroup.leave()
                    }
                })
        }
        
        dispatchGroup.notify(queue: .main) {
            let endTime = NSDate().timeIntervalSince1970 * 1000
            print("Test C duration", endTime - startTime)
        }
    }
}
