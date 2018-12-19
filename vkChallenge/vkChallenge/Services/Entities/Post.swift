//
//  Post.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 10/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation

struct Post: Decodable {
    
    let sourceId: Int64
    let date: TimeInterval
    let postId: Int64
    let text: String
    //let attachments: [PhotoAttachment]
    let comments: Counter
    let likes: Counter
    let reposts: Counter
    let views: Counter?
    let photos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case sourceId
        case ownerId
        case date
        case postId
        case id
        case text
        case comments
        case likes
        case reposts
        case views
        case attachments
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let id = try values.decodeIfPresent(Int64.self, forKey: .sourceId) {
            self.sourceId = id
        } else if let id = try values.decodeIfPresent(Int64.self, forKey: .ownerId) {
            self.sourceId = id
        } else {
            fatalError()
        }
        self.date = try values.decode(TimeInterval.self, forKey: .date)
        
        if let id = try values.decodeIfPresent(Int64.self, forKey: .postId) {
            self.postId = id
        } else if let id = try values.decodeIfPresent(Int64.self, forKey: .id) {
            self.postId = id
        } else {
            fatalError()
        }
        
        self.text = try values.decode(String.self, forKey: .text)
        self.comments = try values.decode(Counter.self, forKey: .comments)
        self.likes = try values.decode(Counter.self, forKey: .likes)
        self.reposts = try values.decode(Counter.self, forKey: .reposts)
        self.views = try values.decodeIfPresent(Counter.self, forKey: .views)
        let attachments = try values.decodeIfPresent([Attachment].self, forKey: .attachments)
        if let attachments = attachments {
            let photoAttachments = attachments.filter { $0.type == "photo" }.compactMap { $0.photo }
            let photos = photoAttachments.compactMap { $0.sizes.first(where: { $0.type == "z"}) }
            self.photos = photos
        } else {
            self.photos = []
        }
    }
}

struct Attachment: Codable {
    
    let type: String
    let photo: PhotoAttachment?
}

struct PhotoAttachment: Codable {
    let id: Int64
    let sizes: [Photo]
}

struct Photo: Codable {
    let type: String
    let url: URL
    let width: Int
    let height: Int
    
}
