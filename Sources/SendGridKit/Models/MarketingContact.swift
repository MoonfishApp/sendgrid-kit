//
//  File.swift
//  
//
//  Created by Ronald Mannak on 11/6/22.
//

import Foundation

public final class MarketingContact: Codable {
 
    public var email: String
    public var first_name: String
    public var last_name: String
    
    public init(email: String, first_name: String, last_name: String) {
        self.email = email
        self.first_name = first_name
        self.last_name = last_name
    }
}

// TODO: make generic
public final class MarketingContactWrapper: Codable {
    public var result: [MarketingContact]
}
