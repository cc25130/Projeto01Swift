import Foundation

enum BookServiceError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case noBooks
}

final class BookService {
    static let shared = BookService()

    private let apiKey = "AIzaSyClL-H6Pe1B16IIGhtiQfcx8gj1SRVyubU"
    private init() {}

    func fetchBooks(category: String) async throws -> [Livro] {
        guard var components = URLComponents(string: "https://www.googleapis.com/books/v1/volumes") else {
            throw BookServiceError.invalidURL
        }

        components.queryItems = [
            URLQueryItem(name: "q", value: "subject:\(category)"),
            URLQueryItem(name: "maxResults", value: "20"),
            URLQueryItem(name: "printType", value: "books"),
            URLQueryItem(name: "orderBy", value: "relevance"),
            URLQueryItem(name: "key", value: apiKey)
        ]

        guard let url = components.url else {
            throw BookServiceError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw BookServiceError.invalidResponse
        }

        do {
            let result = try JSONDecoder().decode(RespostaApi.self, from: data)

            let books = Array(result.items.prefix(5))

            if books.isEmpty {
                throw BookServiceError.noBooks
            }

            return books
        } catch let error as BookServiceError {
            throw error
        } catch {
            throw BookServiceError.decodingError
        }
    }
}
