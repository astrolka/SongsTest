//
//  DataBaseManager.swift
//  SongsTest
//
//  Created by Александр Смоленский on 30.04.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import Foundation
import CoreData

class DataBaseManager {

    static let shared = DataBaseManager()
    private init() { }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func updateCoreDataSongRecords(_ songList: SongsListServerModel) {
        var songsDict = [Int : SongServerModel]()
        var songsIds = [Int]()
        
        for song in songList.songModels {
            if let id = song.id {
                songsDict[id] = song
                songsIds.append(id)
            }
        }
        
        let updatePredicate = NSPredicate(format: "id IN %@", songsIds)
        let deletePredicate = NSPredicate(format: "NOT (id IN %@)", songsIds)
        
        let songsToUpdate = songsWithPredicate(updatePredicate)
        let songsToDelete = songsWithPredicate(deletePredicate)
        
        let songsIdsToUpdate = songsToUpdate.map { songDataBaseModel -> Int in
            return songDataBaseModel.id.intValue
        }
        
        let songsToInsert = songList.songModels.filter { song in
            guard let id = song.id else {
                return false
            }
            return !songsIdsToUpdate.contains(id)
        }
        
        for song in songsToUpdate {
            if let serverModel = songsDict[song.id.intValue] {
                song.bindServerModel(serverModel)
            }
        }
        
        deleteRecords(songsToDelete)
        
        for songServerModel in songsToInsert {
            let songDBModel = SongDataBaseModel(context: context)
            songDBModel.bindServerModel(songServerModel)
        }
        
        saveContext()
    }
    
    func songsWithPredicate(_ predicate: NSPredicate?) -> [SongDataBaseModel] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Song")
        request.predicate = predicate
        do {
            return try persistentContainer.viewContext.fetch(request) as! [SongDataBaseModel]
        } catch let error {
            print(error)
            return [SongDataBaseModel]()
        }
    }
    
    private func deleteRecords<R: NSManagedObject>(_ records: [R]) {
        for record in records {
            persistentContainer.viewContext.delete(record)
        }
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SongsTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error.localizedDescription)
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
