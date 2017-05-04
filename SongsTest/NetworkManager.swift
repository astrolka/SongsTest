//
//  NetworkManager.swift
//  SongsTest
//
//  Created by Александр Смоленский on 30.04.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {

    static let shared = NetworkManager()
    private init() {}
    
    private let requestUrl = URL(string: "http://tomcat.kilograpp.com/songs/api/songs")
    
    func loadSongListWithSuccessHandler(_ success:@escaping (SongsListServerModel) -> Void, errorHandler:@escaping (NSError?) -> Void) {
        guard let url = self.requestUrl else {
            print("No valid url")
            return
        }
        Alamofire.request(url)
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    if let json = response.value as? [[String : Any]] {
                        success(SongsListServerModel(response: json))
                    }
                case .failure:
                    errorHandler(response.result.error as NSError?)
                }
        }
    }
    
}
