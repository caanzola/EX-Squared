import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = BreedListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                /// Displays an error message if one exists.
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                /// List of cat breeds with navigation to details.
                List(viewModel.breeds, id: \.id) { breed in
                    NavigationLink(destination: BreedDetailView(breed: breed)) {
                        HStack {
                            /// Displays the breed image if available.
                            if let imageUrl = breed.imageURL, let url = URL(string: imageUrl) {
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 50, height: 50)
                                }
                            }
                            
                            /// Displays the breed name and description.
                            VStack(alignment: .leading) {
                                Text(breed.name)
                                    .font(.headline)
                                Text(breed.description ?? "No description available")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .lineLimit(2)
                            }
                        }
                    }
                }
                
                /// Shows a loading indicator while fetching more data.
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else {
                    /// Button to load more breeds.
                    Button(action: {
                        viewModel.fetchBreeds()
                    }) {
                        Text("Load more")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                }
            }
            .navigationTitle("Cat Breeds")
        }
    }
}
