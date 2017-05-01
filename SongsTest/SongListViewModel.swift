//
//  SongListViewModel.swift
//  SongsTest
//
//  Created by Александр Смоленский on 30.04.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import Foundation
import ReactiveSwift
import CoreData
import Result
import JSQDataSourcesKit

class SongListViewModel: NSObject {
    
    let title = "Каталог песен"

    let isLoading = MutableProperty(false)

    var refresh: Action<Void, Void, NoError> {
        let enabled = isLoading.negate()
        return Action<Void, Void, NoError>(enabledIf: enabled) { _ in
            return SignalProducer<Void, NoError> { [weak self] observer, _ in
                self?.loadData()
                observer.sendCompleted()
            }
        }
    }
    
    func loadData() {
        let loadSongsSignalProducer = ViewModelManager.shared
            .loadNewData()
            .on(
            starting: { [weak self] in
                self?.isLoading.value = true
            }, failed: { (error) in
                print(error)
            })
        
        loadSongsSignalProducer.startWithCompleted { [weak self] in
            self?.isLoading.value = false
        }
    }
    
    //MARK: - Data base
    
    fileprivate var _fetchRequest: NSFetchRequest<NSFetchRequestResult>?
}

extension SongListViewModel {
    func fetchedResultsController() -> FetchedResultsController<SongDataBaseModel> {
        return FetchedResultsController<SongDataBaseModel>(fetchRequest: fetchRequest,
                                                           managedObjectContext: DataBaseManager.shared.context,
                                                           sectionNameKeyPath: nil,
                                                           cacheName: nil)
    }
    
    fileprivate var fetchRequest: NSFetchRequest<NSFetchRequestResult> {
        if let fetchRequest = _fetchRequest {
            return fetchRequest
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Song")
        fetchRequest.fetchBatchSize = 20
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
        
        _fetchRequest = fetchRequest
        
        return _fetchRequest!
    }
}
