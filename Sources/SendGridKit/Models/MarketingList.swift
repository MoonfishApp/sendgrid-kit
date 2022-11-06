//
//  File.swift
//  
//
//  Created by Ronald Mannak on 11/6/22.
//

import Foundation

public final class MarketingList: Decodable {
    
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
public final class MarketingListWrapper: Decodable {
    public var result: [MarketingList]
}
