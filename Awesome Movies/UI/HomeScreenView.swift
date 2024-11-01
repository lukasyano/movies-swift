import AwesomeMoviesUI
import AwesomeMoviesUtilities
import SwiftUI

private enum ViewConstants {
    static let screenPadding: EdgeInsets = .init(top: 4, leading: 10, bottom: 0, trailing: 10)
}

struct HomeScreenView<ViewModel: HomeViewModel>: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Color.brown.opacity(0.2).ignoresSafeArea(.all)

                ScrollViewReader { scrollViewProxy in
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.data) { movie in
                                MovieCard(movie: movie, bookmarkAction: { () })
                                if movie != viewModel.data.last {
                                    Divider()
                                        .background(RandomGradient.generate())
                                        
                                }
                            }
                        }
                    }
                    .padding(ViewConstants.screenPadding)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            withAnimation {
                                LLLPickerView(selectedItem: $viewModel.selectedSortingType)
                                    .onChange(of: viewModel.selectedSortingType) { _ in
                                        withAnimation {
                                            guard
                                                let moviesFirstIndex = viewModel.data.first?.id else { return }
                                            scrollViewProxy.scrollTo(moviesFirstIndex)
                                        }
                                    }
                            }
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            .alert(isPresented:
                Binding(
                    get: { viewModel.uiError != nil },
                    set: { _ in viewModel.uiError = nil }
                )) { uiError }
        }
    }
}

#Preview {
    HomeScreenView(viewModel: .init(container: .init(container: .shared)))
}

private extension HomeScreenView {
    var uiError: Alert {
        .init(
            title: Text("Error"),
            message: Text(viewModel.uiError?.debugDescription ?? ""),
            primaryButton: .default(Text("Retry"), action: { viewModel.refresh() }),
            secondaryButton: .cancel()
        )
    }
}
