import Foundation

enum CategoriaLivro: String, CaseIterable, Hashable {
    case ficcao = "Ficção"
    case fantasia = "Fantasia"
    case misterio = "Mistério"
    case historia = "História"
    case ciencia = "Ciência"

    var apiQuery: String {
        switch self {
        case .ficcao:
            return "fiction"
        case .fantasia:
            return "fantasy"
        case .misterio:
            return "mystery"
        case .historia:
            return "history"
        case .ciencia:
            return "science"
        }
    }

    var icon: String {
        switch self {
        case .ficcao:
            return "book.fill"
        case .fantasia:
            return "sparkles"
        case .misterio:
            return "magnifyingglass"
        case .historia:
            return "building.columns.fill"
        case .ciencia:
            return "atom"
        }
    }

    var description: String {
        switch self {
        case .ficcao:
            return "Descubra histórias e mundos criados pela imaginação."
        case .fantasia:
            return "Explore mundos fantásticos repletos de aventuras."
        case .misterio:
            return "Encontre histórias cheias de enigmas e descobertas."
        case .historia:
            return "Conheça livros sobre diferentes períodos da humanidade."
        case .ciencia:
            return "Explore descobertas, fenômenos e ideias científicas."
        }
    }
}
