import Foundation

final class CachedImageManager: ObservableObject {
    @Published private(set) var currentState: CurrentState?

    private let imageRetriever = ImageRetriever()

    @MainActor
    func load(_ imgUrl: String,
              cache: ImageCache = .shared) async {
        currentState = .loading

        if let imageData = cache.object(for: imgUrl as NSString) {
            currentState = .success(data: imageData)
            #if DEBUG
            print("📱 Fetching image from the cache: \(imgUrl)")
            #endif
            return
        }

        do {
            let data = try await imageRetriever.fetch(imgUrl)
            currentState = .success(data: data)
            cache.set(object: data as NSData,
                      forKey: imgUrl as NSString)
            #if DEBUG
            print("📱 Caching image: \(imgUrl)")
            #endif
        } catch {
            currentState = .failed(error: error)
        }
    }
}

extension CachedImageManager {
    enum CurrentState {
        case loading
        case failed(error: Error)
        case success(data: Data)
    }
}

extension CachedImageManager.CurrentState: Equatable {
    static func == (lhs: CachedImageManager.CurrentState,
                    rhs: CachedImageManager.CurrentState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case let (.failed(lhsError), .failed(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case let (.success(lhsData), .success(rhsData)):
            return lhsData == rhsData
        default:
            return false
        }
    }
}
