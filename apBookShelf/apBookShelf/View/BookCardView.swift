import SwiftUI

struct BookCardView: View {
    let book: Livro

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        Rectangle()
                            .fill(.quaternary)

                        ProgressView()
                    }

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()

                case .failure:
                    ZStack {
                        Rectangle()
                            .fill(.quaternary)

                        Image(systemName: "book.closed")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)
                    }

                @unknown default:
                    Rectangle()
                        .fill(.quaternary)
                }
            }
            .frame(width: 230, height: 330)
            .clipShape(RoundedRectangle(cornerRadius: 18))

            VStack(alignment: .leading, spacing: 6) {
                Text(book.dadosLivro.titulo)
                    .font(.headline)
                    .lineLimit(2)

                if let authors = book.dadosLivro.autores {
                    Text(authors.joined(separator: ", "))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
            }
        }
        .frame(width: 230)
    }

    private var imageURL: URL? {
        guard let thumbnail = book.dadosLivro.linksImagens?.thumbnail else {
            return nil
        }

        let secureURL = thumbnail.replacingOccurrences(of: "http://", with: "https://")

        return URL(string: secureURL)
    }
}

#Preview {
    BookCardView(
        book: Livro(
            id: "1",
            dadosLivro : DadosLivro(
                titulo: "Livro de Exemplo",
                subtitulo: nil,
                autores: ["Autor"],
                editora: "Editora",
                dataPublicacao: "2025",
                descricao: "Descrição do livro.",
                quantidadePaginas: 300,
                categorias: ["Ficção"],
                linksImagens: nil,
                idioma: "pt",
                avaliacaoMedia: 4.5,
                quantidadeAvaliacoes: 100,
                linkPrevia: nil
            )
        )
    )
}
