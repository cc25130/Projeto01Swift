import SwiftUI

struct BookDetailView: View {
    let book: Livro

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                bookImage

                VStack(alignment: .leading, spacing: 10) {
                    Text(book.dadosLivro.titulo)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    if let subtitle = book.dadosLivro.subtitulo {
                        Text(subtitle)
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }

                    if let authors = book.dadosLivro.autores {
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: "person.fill")
                                .foregroundStyle(.secondary)

                            Text(authors.joined(separator: ", "))
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                if let rating = book.dadosLivro.avaliacaoMedia {
                    ratingView(rating: rating)
                }

                if let description = book.dadosLivro.descricao {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Sobre o livro")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text(cleanDescription(description))
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                }

                informationView
            }
            .padding()
        }
        .navigationTitle("Detalhes")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var bookImage: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .empty:
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.quaternary)

                    ProgressView()
                }

            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()

            case .failure:
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.quaternary)

                    Image(systemName: "book.closed")
                        .font(.system(size: 50))
                        .foregroundStyle(.secondary)
                }

            @unknown default:
                RoundedRectangle(cornerRadius: 20)
                    .fill(.quaternary)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 400)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    private func ratingView(rating: Double) -> some View {
        HStack(spacing: 8) {
            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)

            Text(String(format: "%.1f", rating))
                .fontWeight(.semibold)

            if let ratingsCount = book.dadosLivro.quantidadeAvaliacoes {
                Text("(\(ratingsCount) avaliações)")
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var informationView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Informações")
                .font(.title2)
                .fontWeight(.bold)

            if let publisher = book.dadosLivro.editora {
                informationRow(
                    icon: "building.2",
                    title: "Editora",
                    value: publisher
                )
            }

            if let publishedDate = book.dadosLivro.dataPublicacao {
                informationRow(
                    icon: "calendar",
                    title: "Publicação",
                    value: publishedDate
                )
            }

            if let pageCount = book.dadosLivro.quantidadePaginas {
                informationRow(
                    icon: "book.pages",
                    title: "Páginas",
                    value: "\(pageCount)"
                )
            }

            if let categories = book.dadosLivro.categorias {
                informationRow(
                    icon: "tag",
                    title: "Categoria",
                    value: categories.joined(separator: ", ")
                )
            }

            if let language = book.dadosLivro.idioma {
                informationRow(
                    icon: "globe",
                    title: "Idioma",
                    value: language.uppercased()
                )
            }
        }
        .padding()
        .background(.quaternary.opacity(0.35))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }

    private func informationRow(
        icon: String,
        title: String,
        value: String
    ) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .frame(width: 24)
                .foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(value)
                    .font(.body)
            }

            Spacer()
        }
    }

    private var imageURL: URL? {
        let links = book.dadosLivro.linksImagens

        let image = links?.large
            ?? links?.medium
            ?? links?.small
            ?? links?.thumbnail
            ?? links?.smallThumbnail

        guard let image else {
            return nil
        }

        let secureURL = image.replacingOccurrences(of: "http://", with: "https://")

        return URL(string: secureURL)
    }

    private func cleanDescription(_ text: String) -> String {
        text.replacingOccurrences(
            of: "<[^>]+>",
            with: "",
            options: .regularExpression
        )
    }
}

#Preview {
    NavigationStack {
        BookDetailView(
            book: Livro(
                id: "1",
                dadosLivro: DadosLivro(
                    titulo: "Livro de Exemplo",
                    subtitulo: "Um subtítulo",
                    autores: ["Autor"],
                    editora: "Editora",
                    dataPublicacao: "2025",
                    descricao: "<p>Esta é uma descrição de exemplo.</p>",
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
}
