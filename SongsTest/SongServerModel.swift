//
//  SongServerModel.swift
//  SongsTest
//
//  Created by Александр Смоленский on 30.04.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import Foundation
import SwiftyJSON

class SongServerModel {
    
    let id: Int?
    let author: String?
    let songName: String?
    
    init(response: [String : Any]) {
        let jsonData = JSON(response)
        
        id = jsonData["id"].int
        author = jsonData["author"].string
        songName = jsonData["label"].string
        
    }
}
