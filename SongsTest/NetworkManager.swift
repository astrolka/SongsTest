//
//  NetworkManager.swift
//  SongsTest
//
//  Created by Александр Смоленский on 30.04.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import Foundation
import Alamofire
import ReactiveSwift

class NetworkManager {

    static let shared = NetworkManager()
    private init() {}
    
    private let requestUrl = URL(string: "http://tomcat.kilograpp.com/songs/api/songs")
    
    func songsListSignalProducer() -> SignalProducer<SongsListServerModel, NSError> {
        return SignalProducer { [weak self] (observer, _) in
            guard let url = self?.requestUrl else {
                print("No valid url")
                return
            }
            Alamofire.request(url)
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    if let json = response.value as? [[String : Any]] {
                        observer.send(value: SongsListServerModel(response: json))
                    }
                    observer.sendCompleted()
                case .failure:
                    if let error = response.error as? NSError {
                        observer.send(error: error)
                    }
                    observer.sendCompleted()
                }
            }
        }
    }
    
}
