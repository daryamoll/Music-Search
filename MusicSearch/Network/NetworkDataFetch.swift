//
//  NetworkDataFetch.swift
//  MusicSearch
//
//  Created by Daria on 16.06.2022.
//

import Foundation

class NetworkDataFetch {
    static let shared = NetworkDataFetch()
    
    private init() {}
    
    func fetchAlbum(urlString: String, responce: @escaping(AlbumsModel?, Error?) -> Void) {
        
        NetworkRequest.shared.requestData(urlString: urlString) { result in
            
            switch result {
                    
                case .success(let data):
                    do {
                        let albums = try JSONDecoder().decode(AlbumsModel.self, from: data)
                        responce(albums, nil)
                    } catch let jsonError {
                        print("Failed to decode JSON", jsonError)
                    }
                case .failure(let error):
                    print("Error received request data: \(error.localizedDescription)")
                    responce(nil, error)
            }
        }
    }
    
    func fetchSongs(urlString: String, responce: @escaping(SongsModel?, Error?) -> Void) {
        
        NetworkRequest.shared.requestData(urlString: urlString) { result in
            
            switch result {
                    
                case .success(let data):
                    do {
                        let albums = try JSONDecoder().decode(SongsModel.self, from: data)
                        responce(albums, nil)
                    } catch let jsonError {
                        print("Failed to decode JSON", jsonError)
                    }
                case .failure(let error):
                    print("Error received request data: \(error.localizedDescription)")
                    responce(nil, error)
            }
        }
    }
}
