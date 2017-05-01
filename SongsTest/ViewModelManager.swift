//
//  ViewModelManager.swift
//  SongsTest
//
//  Created by Александр Смоленский on 30.04.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import Foundation
import ReactiveSwift

class ViewModelManager {
    
    static let shared = ViewModelManager()
    private init() { }
    
    func loadNewData() -> SignalProducer<Void, NSError> {
        
        return SignalProducer { observer, _ in
            NetworkManager.shared.songsListSignalProducer()
                    .startWithResult({ (result) in
                        switch result {
                        case .success(let songList):
                            DataBaseManager.shared.updateCoreDataSongRecords(songList)
                            observer.sendCompleted()
                        case .failure(let error):
                            observer.send(error: error)
                            observer.sendCompleted()
                        }
                    })
        }
    }
    
}
