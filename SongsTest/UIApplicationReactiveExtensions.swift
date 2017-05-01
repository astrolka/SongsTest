//
//  UIApplicationReactiveExtensions.swift
//  SongsTest
//
//  Created by Александр Смоленский on 01.05.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import Foundation
import ReactiveSwift
import UIKit

extension Reactive where Base: UIApplication {
    public var isNetworkActivityIndicatorVisible: BindingTarget<Bool> {
        return makeBindingTarget { $0.isNetworkActivityIndicatorVisible = $1 }
    }
}
