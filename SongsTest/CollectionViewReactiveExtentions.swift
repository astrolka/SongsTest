//
//  CollectionViewReactiveExtentions.swift
//  SongsTest
//
//  Created by Александр Смоленский on 30.04.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift

extension Reactive where Base: UICollectionView {
    public var insert: BindingTarget<[IndexPath]> {
        return makeBindingTarget { (collectionView, indexPaths) in
            collectionView.insertItems(at: indexPaths)
        }
    }
    
    public var delete: BindingTarget<[IndexPath]> {
        return makeBindingTarget { (collectionView, indexPaths) in
            collectionView.deleteItems(at: indexPaths)
        }
    }
    
    public var reload: BindingTarget<[IndexPath]> {
        return makeBindingTarget { (collectionView, indexPaths) in
            collectionView.reloadItems(at: indexPaths)
        }
    }
}
