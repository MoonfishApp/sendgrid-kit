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


/*
"address_line_1" : "",
"postal_code" : "",
"country" : "",
"list_ids" : [
  "64c61420-41d8-455a-b33f-37e82d6827be",
  "87015f7d-432f-40d2-a5d6-773f4d7fc129"
],
"updated_at" : "2022-11-06T15:07:34Z",
"facebook" : "",
"city" : "",
"last_name" : "Mannak",
"id" : "154c189c-13ed-4bcb-aeb4-63c72a6fbb38",
"line" : "",
"address_line_2" : "",
"alternate_emails" : [

],
"email" : "ronaldmannak@me.com",
"phone_number" : "",
"unique_name" : "",
"custom_fields" : {

},
"_metadata" : {
  "self" : "https:\/\/api.sendgrid.com\/v3\/marketing\/contacts\/154c189c-13ed-4bcb-aeb4-63c72a6fbb38"
},
"created_at" : "2022-10-17T21:30:26Z",
"first_name" : "Ronald",
"whatsapp" : "",
"state_province_region" : ""
*/
