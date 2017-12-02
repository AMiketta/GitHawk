//
//  Client.swift
//  Freetime
//
//  Created by Sherlock, James on 02/12/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

final class Client: NSObject, NSCoding {
    
    enum Keys {
        static let type = "type"
        static let baseUrl = "baseUrl"
    }
    
    enum ClientType: String {
        case github
        case githubEnterprise
    }
    
    let type: ClientType
    let baseUrl: String
    
    override init() {
        self.type = .github
        self.baseUrl = "github.com"
        super.init()
    }
    
    init(type: ClientType = .githubEnterprise, baseUrl: String) {
        self.type = type
        self.baseUrl = baseUrl
    }
    
    // MARK: NSCoding
    
    convenience init?(coder aDecoder: NSCoder) {
        let storedType = aDecoder.decodeObject(forKey: Keys.type) as? String
        
        let type = storedType.flatMap(ClientType.init) ?? .github
        guard let baseUrl = aDecoder.decodeObject(forKey: Keys.baseUrl) as? String else {
            return nil
        }
        
        self.init(type: type, baseUrl: baseUrl)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(type.rawValue, forKey: Keys.type)
        aCoder.encode(baseUrl, forKey: Keys.baseUrl)
    }
    
}

extension Client {
    
    var graphQLUrl: String {
        switch type {
        // https://developer.github.com/v4/guides/forming-calls/#the-graphql-endpoint
        case .github: return "https://api.\(baseUrl)/graphql"
            
        // https://developer.github.com/enterprise/2.11/v4/guides/forming-calls/#the-graphql-endpoint
        case .githubEnterprise: return "https://\(baseUrl)/api/graphql"
        }
    }
    
    var fullUrl: String {
        return "https://\(baseUrl)"
    }
    
    func repoUrl(owner: String, name: String) -> String {
        return "\(fullUrl)/\(owner)/\(name)"
    }
    
    var statusAPIUrl: String? {
        switch type {
        // https://status.github.com/api
        case .github: return "https://status.\(baseUrl)/api/status.json"
        
        // Enterprise doesn't support this
        case .githubEnterprise: return nil
        }
    }
    
}
