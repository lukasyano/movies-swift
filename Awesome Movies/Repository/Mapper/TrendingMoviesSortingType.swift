import AwesomeMoviesUtilities

enum TrendingMoviesSortingType: String, Hashable, CaseIterable, Defaultable {
    case `default` = "Unfiltered"
    case popularity = "Popularity"
    case votes = "Votes"
    case date = "Date"
}
