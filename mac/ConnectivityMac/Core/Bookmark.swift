//
//  Bookmark.swift
//  ConnectivityMac
//
//  Created by Liu YuanYuan on 2019/7/23.
//  Copyright © 2019 Liu YuanYuan. All rights reserved.
//

import Foundation

class Bookmark: NSCoder {
    var title: String?
    var displayTitle: String?
    var url: String?
    var itemId: String?
    var parentId: String?
    var siblingIndex: UInt64?
    var faviconUrl: String?
    var isFolder: Bool?
    var type: String?
    var creationDate: Date?
    var modifyDate: Date?
    
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.title = decoder.decodeObject(forKey: "title") as? String
        self.displayTitle = decoder.decodeObject(forKey: "displayTitle") as? String
        self.url = decoder.decodeObject(forKey: "url") as? String
        self.itemId = decoder.decodeObject(forKey: "itemId") as? String
        self.parentId = decoder.decodeObject(forKey: "parentId") as? String ?? ""
        self.siblingIndex = decoder.decodeObject(forKey: "siblingIndex") as? UInt64
        self.faviconUrl = decoder.decodeObject(forKey: "faviconUrl") as? String
        self.isFolder = decoder.decodeBool(forKey: "isFolder")
        self.type = decoder.decodeObject(forKey: "type") as? String
        self.creationDate = decoder.decodeObject(forKey: "creationDate") as? Date
        self.modifyDate = decoder.decodeObject(forKey: "modifyDate") as? Date
    }
    
    func encode(with coder: NSCoder) {
        if let title = title { coder.encode(title, forKey: "title") }
        if let displayTitle = displayTitle { coder.encode(displayTitle, forKey: "displayTitle") }
        if let url = url { coder.encode(url, forKey: "url") }
        if let itemId = itemId { coder.encode(itemId, forKey: "itemId") }
        coder.encode(parentId, forKey: "parentId")
        if let siblingIndex = siblingIndex { coder.encode(siblingIndex, forKey: "siblingIndex") }
        if let faviconUrl = faviconUrl { coder.encode(faviconUrl, forKey: "faviconUrl") }
        coder.encode(isFolder, forKey: "isFolder")
        if let type = type { coder.encode(type, forKey: "type") }
        if let creationDate = creationDate { coder.encode(creationDate, forKey: "creationDate") }
        if let modifyDate = modifyDate { coder.encode(modifyDate, forKey: "modifyDate") }
    }
}
