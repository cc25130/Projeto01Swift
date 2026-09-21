import Foundation

struct RespostaApi: Decodable {
    let totalItens: Int
    let itens: [Livro]?
}

struct Livro: Decodable, Hashable, Identifiable {
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
}

struct LinksImagens: Decodable, Hashable {
    let smallThumbnail: String?
    let thumbnail: String?
    let small: String?
    let medium: String?
    let large: String?
}
