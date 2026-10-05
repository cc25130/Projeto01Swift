import Foundation

enum CategoriaLivro: String, CaseIterable, Hashable, Identifiable {
    case ficcao = "Ficção"
    case fantasia = "Fantasia"
    case misterio = "Mistério"
    case historia = "História"
    case ciencia = "Ciência"
    
    var id: String {
        rawValue
    }
    
    var consultaAPI: String {
        switch self {
        case .ficcao:
            return "subject:fiction"
        case .fantasia:
            return "subject:fantasy"
        case .misterio:
            return "subject:mystery"
        case .historia:
            return "subject:history"
        case .ciencia:
            return "subject:science"
        }
    }
    
    var icone: String {
        switch self {
        case .ficcao:
            return "book.closed"
        case .fantasia:
            return "sparkles"
        case .misterio:
            return "magnifyingglass"
        case .historia:
            return "clock.arrow.circlepath"
        case .ciencia:
            return "atom"
        }
    }
}
