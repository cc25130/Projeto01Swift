import Foundation

enum ErroLivros: LocalizedError {
    case urlInvalida
    case respostaInvalida
    case nenhumLivro
    
    var errorDescription: String? {
        switch self {
        case .urlInvalida:
            return "Não foi possível criar o endereço da pesquisa."
        case .respostaInvalida:
            return "A resposta da API é inválida."
        case .nenhumLivro:
            return "Nenhum livro foi encontrado."
        }
    }
}

struct BookService {
    func buscarLivros(categoria: CategoriaLivro) async throws -> [Livro] {
        guard var components = URLComponents(
            string: "https://www.googleapis.com/books/v1/volumes"
        ) else {
            throw ErroLivros.urlInvalida
        }
        
        components.queryItems = [
            URLQueryItem(name: "q", value: categoria.consultaAPI),
            URLQueryItem(name: "maxResults", value: "5"),
            URLQueryItem(name: "printType", value: "books"),
            URLQueryItem(name: "key", value: "AIzaSyClL-H6Pe1B16IIGhtiQfcx8gj1SRVyubU"),

        ]
        
        guard let url = components.url
        else {
            throw ErroLivros.urlInvalida
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let resposta = response as? HTTPURLResponse, (200...299).contains(resposta.statusCode)
        else {
            throw ErroLivros.respostaInvalida
        }
        
        let resultado = try JSONDecoder().decode(
            RespostaLivros.self,
            from: data
        )
        
        let livros = Array(resultado.itens?.prefix(5) ?? [])
        
        guard !livros.isEmpty else {
            throw ErroLivros.nenhumLivro
        }
        
        return livros
    }
}
