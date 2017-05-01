//
//  DictionaryExtentions.swift
//  SongsTest
//
//  Created by Александр Смоленский on 30.04.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import Foundation

extension Dictionary {
    init(keys: [Key], values: [Value]) {
        self.init()
        
        for (key, value) in zip(keys, values) {
            self[key] = value
        }
    }
}
