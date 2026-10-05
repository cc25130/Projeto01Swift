import Foundation
import Observation

@Observable
final class BookViewModel {
    var livros: [Livro] = []
    var carregando = false
    var mensagemErro: String?
    
    private let service = BookService()
    private let categoria: CategoriaLivro
    
    init(categoria: CategoriaLivro) {
        self.categoria = categoria
    }
    
    func carregarLivros() async {
        carregando = true
        mensagemErro = nil
        
        do {
            livros = try await service.buscarLivros(categoria: categoria)
        } catch {
            mensagemErro = error.localizedDescription
        }
        
        carregando = false
    }
}
