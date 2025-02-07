import Foundation

class BreedListViewModel: ObservableObject {
    @Published var breeds: [CatBreed] = []
    @Published var errorMessage: String?
    @Published var isLoading = false  // Prevents multiple API calls at the same time

    private let apiService = APIService()
    private var currentPage = 1
    private let limit = 10
    private var isInitialLoad = true  // Differentiates the first load from subsequent ones
    
    init() {
        fetchBreeds()  // Automatically fetch breeds when initialized
    }
    
    /// Fetches a new page of cat breeds from the API.
    func fetchBreeds() {
        guard !isLoading else { return }
        isLoading = true
        
        apiService.fetchBreeds(page: currentPage, limit: limit) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let newBreeds):
                    self.breeds.append(contentsOf: newBreeds)
                    self.currentPage += 1
                    self.errorMessage = nil
                    
                    /// Fetches images for newly loaded breeds.
                    for index in (self.breeds.count - newBreeds.count)..<self.breeds.count {
                        if let referenceID = self.breeds[index].referenceImageID {
                            self.fetchImage(for: referenceID, at: index)
                        }
                    }
                    
                case .failure(let error):
                    self.errorMessage = self.getErrorMessage(for: error)
                }
            }
        }
    }
    
    /// Fetches the image URL for a specific breed and updates the list.
    func fetchImage(for referenceID: String, at index: Int) {
        apiService.fetchImageURL(for: referenceID) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let url):
                    if index < self.breeds.count {
                        self.breeds[index].imageURL = url
                    }
                case .failure(let error):
                    print("Error fetching image:", error)
                    self.errorMessage = self.getErrorMessage(for: error)
                }
            }
        }
    }
    
    /// Returns a user-friendly error message based on the API error.
    private func getErrorMessage(for error: APIError) -> String {
        switch error {
        case .invalidURL:
            return "Invalid URL. Please try again."
        case .requestFailed:
            return "Connection error. Check your internet."
        case .decodingError:
            return "Failed to process data. Try again later."
        case .imagesError:
            return "Failed to retrieve images. Try again later."
        }
    }
}
