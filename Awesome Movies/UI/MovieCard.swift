import SwiftUI

private enum ViewConstants {
    static let verticalSpacing: CGFloat = 6
    static let maxCardHeight: CGFloat = 200
    static let maxImageHeight: CGFloat = 180
    static let maxImageWidth: CGFloat = 120
    static let bookMarkImage: Image = .init(systemName: "star")
    static let descriptionMaxLines: Int = 3
}

struct MovieCard: View {
    let movie: MovieEntity
    let bookmarkAction: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            CachedImage(url: movie.posterURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()

                case let .success(image):
                    image.resizable()
                        .scaledToFit()
                        .frame(width: ViewConstants.maxImageWidth, height: ViewConstants.maxImageHeight)
                        .cornerRadius(2)

                case let .failure(error):
                    let _ = Log.error(error.localizedDescription, category: .event)
                    Color.gray

                @unknown default:
                    EmptyView()
                }
            }
            .frame(
                width: ViewConstants.maxImageWidth,
                height: ViewConstants.maxImageHeight
            )

            VStack(alignment: .leading, spacing: ViewConstants.verticalSpacing) {
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(1)

                Text(movie.overview)
                    .font(.subheadline)
                    .lineLimit(ViewConstants.descriptionMaxLines)
                Spacer()

                HStack {
                    Spacer()

                    VStack(alignment: .trailing, spacing: ViewConstants.verticalSpacing) {
                        HStack {
                            Text(movie.voteAverage)
                                .font(.subheadline)
                            Button(action: bookmarkAction) {
                                ViewConstants.bookMarkImage
                            }
                        }

                        Text(movie.releaseDate)
                            .font(.footnote)
                    }
                }
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: ViewConstants.maxCardHeight)
    }
}

#Preview { MovieCard(movie: .mock, bookmarkAction: { }) }
