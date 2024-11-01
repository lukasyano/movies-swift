public struct MovieResult: Decodable {
    public let adult: Bool?
    public let backdropPath: String?
    public let genreIDs: [Int]?
    public let id: Int?
    public let mediaType: String?
    public let originalLanguage: String?
    public let originalTitle: String?
    public let overview: String?
    public let popularity: Double?
    public let posterPath: String?
    public let releaseDate: String?
    public let title: String?
    public let video: Bool?
    public let voteAverage: Double?
    public let voteCount: Int?

    public init(
        adult: Bool?,
        backdropPath: String?,
        genreIDs: [Int]?,
        id: Int?,
        mediaType: String?,
        originalLanguage: String?,
        originalTitle: String?,
        overview: String?,
        popularity: Double?,
        posterPath: String?,
        releaseDate: String?,
        title: String?,
        video: Bool?,
        voteAverage: Double?,
        voteCount: Int?
    ) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIDs = genreIDs
        self.id = id
        self.mediaType = mediaType
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case id
        case mediaType = "media_type"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
