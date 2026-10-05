import Foundation
import Combine

@MainActor
final class BookViewModel: ObservableObject {
    @Published var livros: [Livro] = []
    @Published var carregando = false
    @Published var mensagemErro: String?
    
    private let service = BookService()
    private let categoria: CategoriaLivro
    
    init(categoria: CategoriaLivro) {
        self.categoria = categoria
    }
    
    func carregarLivros() async {
        carregando = true
        mensagemErro = nil
        
        do {
            livros = try await service.buscarLivros(
                categoria: categoria
            )
        } catch {
            mensagemErro = error.localizedDescription
        }
        
        carregando = false
    }
}
