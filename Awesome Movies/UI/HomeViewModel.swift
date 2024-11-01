import Combine
import Factory
import SwiftUI

class HomeViewModel: ObservableObject {
    private let trendingMoviesRepository: TrendingMoviesRepository
    private var cancellables = Set<AnyCancellable>()

    @Published var data = [MovieEntity]()
    @Published var uiError: String?
    @Published var selectedSortingType: TrendingMoviesSortingType = .default {
        didSet { getTrendingMovies(sortingType: selectedSortingType) }
    }

    init(container: HomeDependencies) {
        trendingMoviesRepository = container.moviesRepository()
        getTrendingMovies()
    }

    private func getTrendingMovies(pageNr: Int = 1, sortingType: TrendingMoviesSortingType = .popularity) {
        trendingMoviesRepository.getTrendingMovies(pageNr: 1, sortingType: selectedSortingType)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case let .failure(error):
                    self?.uiError = error.localizedDescription
                }
            } receiveValue: { [weak self] movieEntities in
                self?.data = movieEntities
            }
            .store(in: &cancellables)
    }

    func refresh(_ sortingType: TrendingMoviesSortingType = .popularity) {
        getTrendingMovies(sortingType: selectedSortingType)
    }
}
