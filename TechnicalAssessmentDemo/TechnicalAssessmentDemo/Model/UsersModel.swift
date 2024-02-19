//
//  UsersModel.swift
//  TechnicalAssessmentDemo
//
//  Created by Anas Hamad on 2/19/24.
//

import Foundation


struct UsersModel: Codable, Hashable {
    let code: Int?
    let meta: Meta?
    let data: [DataModel]?

    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
        hasher.combine(meta)
        hasher.combine(data)
    }
}

// MARK: - Datum
struct DataModel: Codable, Hashable {
    let id: Int
    let name, email: String
    let gender: Gender
    let status: Status

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(email)
        hasher.combine(gender)
        hasher.combine(status)
    }
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
}

enum Status: String, Codable {
    case active = "active"
    case inactive = "inactive"
}

// MARK: - Meta
struct Meta: Codable, Hashable {
    let pagination: Pagination

    func hash(into hasher: inout Hasher) {
        hasher.combine(pagination)
    }
}

// MARK: - Pagination
struct Pagination: Codable,Hashable {
    let total, pages, page, limit: Int
}
