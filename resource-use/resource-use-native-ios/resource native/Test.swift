//
//  Test.swift
//  resource native
//
//  Created by Iman Jamali on 2021-10-13.
//

import Foundation

func isPrime(num:Int) -> Bool {
    if (num < 2) {
        return false;
    }
    for i in 2..<num {
        if (num % i == 0) {
            return false;
        }
    }
    return true;
}


func findPrimes(maxNum:Int) -> [Int] {
    var primes:[Int] = []
    for i in 0...maxNum {
        if (isPrime(num: i)) {
            primes.append(i)
        }
    }
    return primes
}

func transitiveClosure(graph: [[Int]], V:Int) {
    var reach = [[Int]](repeating: [Int](repeating: 0, count: V), count: V)
    
    for i in 0..<V {
        for j in 0..<V {
            reach[i][j] = graph[i][j];
        }
    }
    
    for k in 0..<V {
        for i in 0..<V {
            for j in 0..<V {
                if (reach[i][j] != 0) {
                    reach[i][j] = reach[i][j]
                } else {
                    if (reach[i][k] != 0 && reach[k][j] != 0) {
                        reach[i][j] = 1
                    } else {
                        reach[i][j] = 0
                    }
                }
            }
        }
    }
}
