import Foundation

extension NSError {
    static func invalidURL(_ url: String) -> Self {
        .init(
            domain: url,
            code: 1001,
            userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]
        )
    }
}
