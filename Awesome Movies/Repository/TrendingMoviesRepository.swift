import Combine
import Factory
import Foundation

protocol TrendingMoviesRepository {
    func getTrendingMovies(pageNr: Int, sortingType: TrendingMoviesSortingType) -> AnyPublisher<[MovieEntity], Error>
}

class DefaultTrendingMoviesRepository: TrendingMoviesRepository {
    private let api: ApiService
    private let dao: MoviesDao

    init(container: HomeDependencies) {
        self.api = container.moviesApiService()
        self.dao = container.moviesDao()
    }

    func getTrendingMovies(pageNr: Int, sortingType: TrendingMoviesSortingType) -> AnyPublisher<[MovieEntity], Error> {
        return api.getTrendingMovies(pageNr: pageNr)
            .map { movieResponse in
                Mapper.mapMovies(results: movieResponse.results, sortingType: sortingType)
            }
            .catch { error -> AnyPublisher<[MovieEntity], Error> in
                Log.error(error.localizedDescription, category: .state)
                return Fail(error: error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
