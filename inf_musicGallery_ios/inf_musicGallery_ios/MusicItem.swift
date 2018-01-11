//
//  MusicItem.swift
//  inf_musicGallery_ios
//
//  Created by Kamil Buczel on 25.04.2017.
//  Copyright © 2017 Kamajabu. All rights reserved.
//

import Foundation

class MusicItem {
    var fileName: String
    var itemImage: String
    var title: String
    var artist: String

    init(dataDictionary:Dictionary<String,String>) {
        fileName = dataDictionary["fileName"]!
        artist = dataDictionary["artist"]!
        title = dataDictionary["title"]!
        itemImage = dataDictionary["itemImage"]!

    }
    
    class func newGalleryItem(_ dataDictionary:Dictionary<String,String>) -> GalleryItem {
        return GalleryItem(dataDictionary: dataDictionary)
    }
}
