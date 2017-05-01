//
//  SongDataBaseModel.swift
//  SongsTest
//
//  Created by Александр Смоленский on 30.04.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import CoreData

@objc(SongDataBaseModel)
class SongDataBaseModel: NSManagedObject {
    
    @NSManaged var author: String?
    @NSManaged var songName: String?
    @NSManaged var id: NSNumber
    
    public init(context: NSManagedObjectContext) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Song", in: context)!
        super.init(entity: entityDescription, insertInto: context)
    }
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
}

extension SongDataBaseModel: DataBaseModel {
    
    func bindServerModel(_ model: SongServerModel) {
        guard let id = model.id else {
            return
        }
        self.author = model.author
        self.songName = model.songName
        
        self.id = NSNumber(integerLiteral: id)
    }
    
}
