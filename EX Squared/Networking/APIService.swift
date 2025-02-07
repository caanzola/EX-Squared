import Foundation

class APIService {
    
    /// Fetches a list of cat breeds with pagination.
    func fetchBreeds(page: Int, limit: Int, completion: @escaping (Result<[CatBreed], APIError>) -> Void) {
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds?page=\(page)&limit=\(limit)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.requestFailed))
                return
            }

            guard let data = data else {
                completion(.failure(.requestFailed))
                return
            }
            
            do {
                let breeds = try JSONDecoder().decode([CatBreed].self, from: data)
                completion(.success(breeds))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    /// Fetches the image URL for a cat breed.
    func fetchImageURL(for referenceID: String, completion: @escaping (Result<String, APIError>) -> Void) {
        let urlString = "https://api.thecatapi.com/v1/images/\(referenceID)"
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.requestFailed))
                return
            }

            guard let data = data else {
                completion(.failure(.requestFailed))
                return
            }

            do {
                let imageResponse = try JSONDecoder().decode(CatImageResponse.self, from: data)
                completion(.success(imageResponse.url))
            } catch {
                completion(.failure(.imagesError))
            }
        }.resume()
    }
}

/// Model for image response.
struct CatImageResponse: Codable {
    let url: String
}

/// Possible API request errors.
enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingError
    case imagesError
}
