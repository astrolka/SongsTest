//
//  SongViewModel.swift
//  SongsTest
//
//  Created by Александр Смоленский on 30.04.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import Foundation

class SongViewModel {
    
    var author: String
    var songName: String
    
    private weak var model: SongDataBaseModel?
    
    init(model: SongDataBaseModel?) {
        self.author = model?.author ?? ""
        self.songName = model?.songName ?? ""
        self.model = model
        
    }
}
