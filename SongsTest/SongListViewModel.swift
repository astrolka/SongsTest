//
//  SongListViewModel.swift
//  SongsTest
//
//  Created by Александр Смоленский on 30.04.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import Foundation
import CoreData
import JSQDataSourcesKit

class SongListViewModel: NSObject {
    
    let title = "Каталог песен"

    let isLoading = Dynamic(false)
    
    func loadData() {
        isLoading.value = true
        ViewModelManager.shared.loadNewDataWithSuccessHandler({ [weak self] in
            self?.isLoading.value = false
        }) { [weak self] (error) in
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
