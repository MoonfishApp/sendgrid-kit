//
//  File.swift
//  
//
//  Created by Ronald Mannak on 11/6/22.
//

import Foundation

public final class MarketingList: Codable {
    
    public var id: String
    public var name: String
    public var contact_count: Int
    
    public init(id: String, name: String, contact_count: Int) {
        self.id = id
        self.name = name
        self.contact_count = contact_count
    }
}


// TODO: make generic
public final class MarketingListWrapper: Codable {
    public var result: [MarketingList]
}
