//
//  BaseErrorModel.swift
//  iOS Task
//
//  Created by mac on 5/28/21.
//

import Foundation
struct BaseErrorModel: Codable {
    let message: String?
    let status_code: Int?
}
