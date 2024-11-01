import Foundation

func extractYear(from dateString: String, dateFormat: String = "yyyy/MM/dd") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat

    guard let date = dateFormatter.date(from: dateString) else { return "" }

    let yearFormatter = DateFormatter()
    yearFormatter.dateFormat = "yyyy / MM"

    return yearFormatter.string(from: date)
}

enum Mapper {
    static func mapMovies(results: [MovieResult], sortingType: TrendingMoviesSortingType) -> [MovieEntity] {
        var sortedResults = results

        switch sortingType {
        case .popularity:
            sortedResults.sort { $0.popularity ?? 0.0 > $1.popularity ?? 0.0 }
        case .votes:
            sortedResults.sort { $0.voteAverage ?? 0 > $1.voteAverage ?? 0 }
        case .date:
            sortedResults.sort { $0.releaseDate ?? "" > $1.releaseDate ?? "" }
        default:
            break
        }

        return sortedResults.map {
            MovieEntity(
                id: $0.id ?? -1,
                title: $0.title ?? "",
                popularity: $0.popularity ?? 0.0,
                overview: $0.overview ?? "",
                releaseDate: extractYear(from: $0.releaseDate ?? ""),
                voteAverage: (round(($0.voteAverage ?? 0.0) * 10) / 10.0).description,
                voteCount: $0.voteCount ?? 0,
                posterURL: Constants.imageBaseURL + ($0.posterPath ?? "")
            )
        }
    }
}
