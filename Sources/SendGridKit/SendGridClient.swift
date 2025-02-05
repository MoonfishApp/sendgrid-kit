import Foundation
import NIO
import AsyncHTTPClient
import NIOHTTP1

public struct SendGridClient {
    
    let apiURL =            "https://api.sendgrid.com/v3/mail/send"
    let templatesURL =      "https://api.sendgrid.com/v3/designs"
    let templateURL =       "https://api.sendgrid.com/v3/designs/{id}"//"https://api.sendgrid.com/v3/templates/{template_id}"
    let marketingListsURL = "https://api.sendgrid.com/v3/marketing/lists"
    let marketingURL =      "https://api.sendgrid.com/v3/marketing/lists/{id}"
    let marketingUsersURL =  "https://api.sendgrid.com/v3/marketing/contacts/search"
    let httpClient: HTTPClient
    let apiKey: String
    
    private let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
         encoder.dateEncodingStrategy = .secondsSince1970
         return encoder
    }()
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()

    public init(httpClient: HTTPClient, apiKey: String) {
        self.httpClient = httpClient
        self.apiKey = apiKey
    }
    
    public func send(email: SendGridEmail) async throws {
                
        var headers = HTTPHeaders()
        headers.add(name: "Authorization", value: "Bearer \(apiKey)")
        headers.add(name: "Content-Type", value: "application/json")
        
        let response = try await httpClient.execute(
            request: .init(
                url: apiURL,
                method: .POST,
                headers: headers,
                body: .data(encoder.encode(email))
            )
        ).get()
        
        // If the request was accepted, simply return
        guard response.status != .ok || response.status == .accepted else { return }
        
        // JSONDecoder will handle empty body by throwing decoding error
        let byteBuffer = response.body ?? ByteBuffer(.init())
                
        throw try decoder.decode(SendGridError.self, from: byteBuffer)
        
    }
    
    public func getContactLists() async throws -> [MarketingList] {
                        
        var headers = HTTPHeaders()
        headers.add(name: "Authorization", value: "Bearer \(apiKey)")
        headers.add(name: "Content-Type", value: "application/json")
        
        let response = try await httpClient.execute(
            request: .init(
                url: marketingListsURL,
                method: .GET,
                headers: headers
            )
        ).get()
    
        let byteBuffer = response.body ?? ByteBuffer(.init())

        // If the request was accepted, throw error
        guard response.status == .ok || response.status == .accepted else {
            throw try decoder.decode(SendGridError.self, from: byteBuffer)
        }
            
        let wrapper = try decoder.decode(MarketingListWrapper.self, from: byteBuffer)
        return wrapper.result
    }
    
    public func getContactList(id: String) async throws { //}-> [ContactList] {
                
        var headers = HTTPHeaders()
        headers.add(name: "Authorization", value: "Bearer \(apiKey)")
        
        let response = try await httpClient.execute(
            request: .init(
                url: marketingURL.replacingOccurrences(of: "{id}", with: id),
                method: .GET,
                headers: headers
            )
        ).get()

        // JSONDecoder will handle empty body by throwing decoding error
        let byteBuffer = response.body ?? ByteBuffer(.init())

        // If the request was accepted, throw error
        guard response.status == .ok || response.status == .accepted else {
            throw try decoder.decode(SendGridError.self, from: byteBuffer)
        }
            
        return
//        let lists = try decoder.decode([ContactList].self, from: byteBuffer)
//        return lists
    }
    
    public func getAllUsers() async throws -> [MarketingContact] {
        
        struct Query: Codable {
            let query: String
        }
        
        var headers = HTTPHeaders()
        headers.add(name: "Authorization", value: "Bearer \(apiKey)")
        headers.add(name: "Content-Type", value: "application/json")
            
        let query = Query(query: "email LIKE '%%'")
        
        let response = try await httpClient.execute(
            request: .init(
                url: marketingUsersURL,
                method: .POST,
                headers: headers,
                body: .data(encoder.encode(query))
            )
        ).get()
    
        let byteBuffer = response.body ?? ByteBuffer(.init())

        // If the request was accepted, throw error
        guard response.status == .ok || response.status == .accepted else {
            throw try decoder.decode(SendGridError.self, from: byteBuffer)
        }
            
        let wrapper = try decoder.decode(MarketingContactWrapper.self, from: byteBuffer)
        return wrapper.result
    }
    
    public func getTemplates() async throws -> [Template] {
                
        var headers = HTTPHeaders()
        headers.add(name: "Authorization", value: "Bearer \(apiKey)")
        
        let response = try await httpClient.execute(
            request: .init(
                url: templatesURL,
                method: .GET,
                headers: headers
            )
        ).get()

        // JSONDecoder will handle empty body by throwing decoding error
        let byteBuffer = response.body ?? ByteBuffer(.init())
        
        print(String(buffer: byteBuffer))

        // If the request was accepted, throw error
        guard response.status == .ok || response.status == .accepted else {
            throw try decoder.decode(SendGridError.self, from: byteBuffer)
        }
            
        let wrapper = try decoder.decode(TemplateWrapper.self, from: byteBuffer)
        return wrapper.result
    }
    
    public func getTemplate(id: String) async throws -> Design {
                
        var headers = HTTPHeaders()
        headers.add(name: "Authorization", value: "Bearer \(apiKey)")
//        headers.add(name: "Content-Type", value: "application/json")
        
        let response = try await httpClient.execute(
            request: .init(
                url: templateURL.replacingOccurrences(of: "{id}", with: "\(id)"),
                method: .GET,
                headers: headers
            )
        ).get()

        // JSONDecoder will handle empty body by throwing decoding error
        let byteBuffer = response.body ?? ByteBuffer(.init())

        // If the request was accepted, throw error
        guard response.status == .ok || response.status == .accepted else {
            throw try decoder.decode(SendGridError.self, from: byteBuffer)
        }
                    
        let design = try decoder.decode(Design.self, from: byteBuffer)
        return design
    }
}
