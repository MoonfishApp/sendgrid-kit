//
//  File.swift
//  
//
//  Created by Ronald Mannak on 11/7/22.
//

import Foundation

public final class Template: Codable {
 
    public let id: String
    public let name: String
    public let subject: String
    public let editor: String
    public let thumbnail: String
    public let createdAt: String
    public let updatedAt: String
    public let generatePlainContent: Bool
//    public let categories: [String?]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case subject
        case editor
        case thumbnail = "thumbnail_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case generatePlainContent = "generate_plain_content"
//        case categories
    }
}

// TODO: make generic
public final class TemplateWrapper: Codable {
    public var result: [Template]
}
