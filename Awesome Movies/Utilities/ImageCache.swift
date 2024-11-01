import Foundation

class ImageCache {
    typealias CacheType = NSCache<NSString, NSData>

    static let shared = ImageCache()

    private init() {}

    private lazy var cache: CacheType = {
        let cache = CacheType()
        cache.countLimit = 1000
        cache.totalCostLimit = 100 * 1024 * 1024 // 52428800 Bytes > 50MB
        return cache
    }()

    func object(for key: NSString) -> Data? {
        cache.object(forKey: key) as? Data
    }

    func set(object: NSData, forKey key: NSString) {
        cache.setObject(object, forKey: key)
    }
}
