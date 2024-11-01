import Combine
import Foundation

protocol ApiService {
    func getTrendingMovies(pageNr: Int) -> AnyPublisher<MoviesResponse, Error>
}

class DefaultApiService: ApiService {
    func getTrendingMovies(pageNr _: Int) -> AnyPublisher<MoviesResponse, Error> {
        guard var urlComponents = URLComponents(string: Constants.moviesBaseURL + Constants.trendingMoviesWeek) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            return Fail(error: error).eraseToAnyPublisher()
        }

        urlComponents.queryItems = [URLQueryItem(name: "api_key", value: Constants.apiKey)]

        guard let url = urlComponents.url else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            return Fail(error: error).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: MoviesResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
