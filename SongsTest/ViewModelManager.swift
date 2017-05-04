//
//  ViewModelManager.swift
//  SongsTest
//
//  Created by Александр Смоленский on 30.04.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import Foundation

class ViewModelManager {
    
    static let shared = ViewModelManager()
    private init() { }
    
    func loadNewDataWithSuccessHandler(_ success:@escaping () -> Void, errorHandler:@escaping (NSError?) -> Void) {
        NetworkManager.shared.loadSongListWithSuccessHandler({ (songsList) in
            DataBaseManager.shared.updateCoreDataSongRecords(songsList)
            success()
        }) { (error) in
            print(error ?? "Unknown error")
            errorHandler(error)
        }
    }
    
}
