//
//  ImageLoader.swift
//  GHFollowers
//
//  Created by Alpay Calalli on 16.08.23.
//

import SwiftUI

class ImageLoader: ObservableObject {
    let urlString: String
    
    @Published var image: UIImage = UIImage(systemName: "person.2")!
    @Published var isLoading = false
    
    init(urlString: String) {
        self.urlString = urlString
        downloadImage { image in
            if let image = image {
                DispatchQueue.main.async { self.image = image }
            }
        }
    }
    
    private let cache = NSCache<NSString, UIImage>()
    
    func downloadImage(completion: @escaping(UIImage?) -> Void ) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode),
                  let data = data,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            
            self.cache.setObject(image, forKey: cacheKey)
            
            completion(image)
        }
        
        task.resume()
        
    }

    
}
