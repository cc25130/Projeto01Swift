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
