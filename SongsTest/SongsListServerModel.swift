//
//  SongsListServerModel.swift
//  SongsTest
//
//  Created by Александр Смоленский on 30.04.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import Foundation

class SongsListServerModel {
    var songModels: [SongServerModel]
    
    init(response: [[String : Any]]) {
        songModels = response.map({ (dict) -> SongServerModel in
            return SongServerModel(response: dict)
        })
    }
}
