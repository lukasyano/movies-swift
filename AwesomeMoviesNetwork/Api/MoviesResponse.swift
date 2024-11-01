public struct MoviesResponse: Decodable {
    public let page: Int?
    public let results: [MovieResult]
    public let totalPages: Int?
    public let totalResults: Int?

    public init(page: Int?, results: [MovieResult], totalPages: Int?, totalResults: Int?) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
