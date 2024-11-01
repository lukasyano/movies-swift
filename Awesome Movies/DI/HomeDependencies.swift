import AwesomeMoviesNetwork
import Factory

struct HomeDependencies {
    let container: Container

    var moviesApiService: Factory<ApiService> {
        Factory(container) { DefaultApiService() }
    }

    var moviesDao: Factory<MoviesDao> {
        Factory(container) { DefaultMoviesDao() }
    }

    var moviesRepository: Factory<TrendingMoviesRepository> {
        Factory(container) { DefaultTrendingMoviesRepository(container: .init(container: .shared)) }
    }

    var moviesViewModel: Factory<HomeViewModel> {
        Factory(container) { HomeViewModel(container: .init(container: .shared)) }
    }
}
