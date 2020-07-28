import UIKit
import Foundation


// MARK: - Image Completion


typealias ImageCompletion = (Photo, UIImage?) -> Void


// MARK: - Image Cache


let Images = ImageCache()

class ImageCache {
    
    private let cache = NSCache<NSURL, UIImage>()
    private var prefetches: [String] = []
    private var completions: [NSURL: [ImageCompletion]] = [:]
    
    
    // MARK: Prefetch
    
    
    func prefetchImage(for photo: Photo) {
        let url = photo.imageURL as NSURL
        
        guard cachedImage(for: url) == nil, !prefetches.contains(photo.id) else { return }
        
        prefetches.append(photo.id)
        
        Network.load(photo.imageRequest) { [weak self] result in
            
            switch result {
            case .success(let image):
                self?.cache.setObject(image, forKey: url)
                self?.prefetches.removeAll { $0 == photo.id }
            default: break
            }
        }
    }
    
    
    // MARK: Cache
    
    
    private func cachedImage(for url: NSURL) -> UIImage? {
        cache.object(forKey: url)
    }
    
    
    // MARK: Load
    
    
    func loadImage(for photo: Photo, completion: @escaping ImageCompletion) {
        let url = photo.imageURL as NSURL
        
        if let image = cachedImage(for: url) {
            completion(photo, image)
            return
        }
        
        if completions[url] != nil {
            completions[url]?.append(completion)
            return
        } else {
            completions[url] = [completion]
        }
        
        Network.load(photo.imageRequest) { [weak self] result in
            switch result {
            case .success(let image):
                guard let completions = self?.completions[url] else {
                    completion(photo, nil)
                    return
                }
                
                self?.cache.setObject(image, forKey: url)
                
                completions.forEach { completion in
                    completion(photo, image)
                }
            case .failure(let error):
                print("ERROR: \(photo.id), \(url), \(error)")
                completion(photo, nil)
            }
            
            self?.completions.removeValue(forKey: url)
        }
    }
    
    
    // MARK: Reset
    
    
    func reset() {
        completions.removeAll()
        prefetches.removeAll()
        cache.removeAllObjects()
    }
}
