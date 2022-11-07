//
//  File.swift
//  
//
//  Created by Ronald Mannak on 11/7/22.
//

import Foundation

public final class Design: Codable {
 
    public let id: String
    public let name: String
    public let editor: String
    public let htmlContent: String
    public let plainContent: String
    public let subject: String
    public let createdAt: String
    public let updatedAt: String
//    public let categories: [String]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case editor
        case htmlContent = "html_content"
        case plainContent = "plain_content"
        case subject
        case createdAt = "created_at"
        case updatedAt = "updated_at"
//        case categories
    }
}
