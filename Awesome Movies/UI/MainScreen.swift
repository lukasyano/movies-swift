import SwiftUI

struct MainScreen: View {
    let dependencies = HomeDependencies(container: .shared)
    
    var body: some View {
        HomeScreenView(viewModel: dependencies.moviesViewModel())
    }
}
