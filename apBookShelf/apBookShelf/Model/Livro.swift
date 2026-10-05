import Foundation

struct RespostaLivros: Decodable {
    let totalItems: Int
    let itens: [Livro]?
}

struct Livro: Decodable, Identifiable, Hashable {
    let id: String
    let dadosLivro: DadosLivro
    
}

struct DadosLivro: Decodable, Hashable {
    let titulo: String
    let subtitulo: String?
    let autores: [String]?
    let editora: String?
    let dataPublicacao: String?
    let descricao: String?
    let quantidadePaginas: Int?
    let categorias: [String]?
    let linksImagens: LinksImagens?
    let idioma: String?
    let avaliacaoMedia: Double?
    let quantidadeAvaliacoes: Int?
    let linkPrevia: String?
    
    enum CodingKeys: String, CodingKey {
        case titulo = "title"
        case subtitulo = "subtitle"
        case autores = "authors"
        case editora = "publisher"
        case dataPublicacao = "publishedDate"
        case descricao = "description"
        case quantidadePaginas = "pageCount"
        case categorias = "categories"
        case linksImagens = "imageLinks"
        case idioma = "language"
        case avaliacaoMedia = "averageRating"
        case quantidadeAvaliacoes = "ratingsCount"
        case linkPrevia = "previewLink"
    }
    
    var capaURL: URL? {
        guard let endereco = linksImagens?.thumbnail ?? linksImagens?.smallThumbnail else {
            return nil
        }
        
        return URL(string: endereco.replacingOccurrences(
            of: "http://",
            with: "https://"
        ))
    }
}

struct LinksImagens: Decodable, Hashable {
    let smallThumbnail: String?
    let thumbnail: String?
    let small: String?
    let medium: String?
    let large: String?
}
