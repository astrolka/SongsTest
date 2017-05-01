//
//  DataBaseModel.swift
//  SongsTest
//
//  Created by Александр Смоленский on 30.04.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import Foundation

protocol DataBaseModel {
    func bindServerModel(_ model: SongServerModel)
}
