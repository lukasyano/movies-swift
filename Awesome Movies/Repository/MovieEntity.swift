import Foundation

struct MovieEntity: Identifiable, Hashable {
    let id: Int
    let title: String
    let popularity: Double
    let overview: String
    let releaseDate: String
    let voteAverage: String
    let voteCount: Int
    let posterURL: String
}

extension MovieEntity {
    static let mock: MovieEntity = .init(
        id: 1,
        title: "Titlle",
        popularity: 2.0,
        overview: "Osadf",
        releaseDate: "sadf",
        voteAverage: "1.0",
        voteCount: 12,
        posterURL: "https://image.tmdb.org/t/p/w342/b33nnKl1GSFbao4l3fZDDqsMx0F.jpg"
    )
}
