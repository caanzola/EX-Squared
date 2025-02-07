import SwiftUI

struct BreedDetailView: View {
    var breed: CatBreed
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                /// Displays the breed image if available, otherwise shows a placeholder.
                AsyncImage(url: URL(string: breed.imageURL ?? "")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .frame(height: 300)
                            .clipped()
                    } else {
                        Text("Failed to retrieve images. Try again later.")
                                .foregroundColor(.red)
                                .padding()
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 300, height: 300)
                        
                    }
                }
                
                Text("Name: \(breed.name)")
                    .font(.headline)
                
                Text("Description: \(breed.description)")
                    .font(.body)
                    .padding(.top, 5)
                
                if let temperament = breed.temperament {
                    Text("Temperament: \(temperament)")
                        .font(.body)
                        .padding(.top, 5)
                }
                
                if let energyLevel = breed.energyLevel {
                    Text("Energy Level: \(energyLevel)")
                        .font(.body)
                        .padding(.top, 5)
                }
                
                if let wikipediaURL = breed.wikipediaURL, let url = URL(string: wikipediaURL) {
                    Link("More Info", destination: url)
                        .font(.body)
                        .padding(.top, 5)
                }
            }
            .padding()
        }
        .navigationTitle(breed.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
