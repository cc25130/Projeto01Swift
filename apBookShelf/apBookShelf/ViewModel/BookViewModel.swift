import Foundation
import Observation

@Observable
final class BookViewModel {
    var books: [Livro] = []
    var isLoading = false
    var errorMessage: String?

    func fetchBooks(category: CategoriaLivro) async {
        isLoading = true
        errorMessage = nil
        books = []

        do {
            books = try await BookService.shared.fetchBooks(category: category.apiQuery)
        } catch BookServiceError.noBooks {
            errorMessage = "Não encontramos livros para esta categoria."
        } catch BookServiceError.invalidResponse {
            errorMessage = "O servidor não respondeu corretamente."
        } catch BookServiceError.decodingError {
            errorMessage = "Não foi possível interpretar os dados dos livros."
        } catch {
            errorMessage = "Não foi possível carregar os livros. Verifique sua conexão."
        }

        isLoading = false
    }
}
