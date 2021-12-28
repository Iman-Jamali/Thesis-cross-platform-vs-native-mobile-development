import Foundation

struct Todo: Codable {
    let id: String
    let title: String
    let description: String
}

struct Message: Codable {
    let message: String
}

struct Id: Codable {
    let id: String
}


