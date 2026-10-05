import SwiftUI

struct BookDetailView: View {

    let livro: Livro

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.07, blue: 0.12),
                    Color(red: 0.10, green: 0.08, blue: 0.18),
                    Color(red: 0.04, green: 0.05, blue: 0.09)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 25) {

                    AsyncImage(url: livro.dadosLivro.capaURL) { phase in
                        switch phase {
                        case .empty:
                            ZStack {
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(.white.opacity(0.08))

                                ProgressView()
                                    .tint(.white)
                            }

                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()

                        case .failure:
                            ZStack {
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(.white.opacity(0.08))

                                Image(systemName: "book.closed")
                                    .font(.system(size: 55))
                                    .foregroundStyle(.white.opacity(0.5))
                            }

                        default:
                            RoundedRectangle(cornerRadius: 24)
                                .fill(.white.opacity(0.08))
                        }
                    }
                    .frame(width: 210, height: 310)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 24)
                    )
                    .shadow(
                        color: .black.opacity(0.4),
                        radius: 20,
                        y: 12
                    )

                    VStack(spacing: 8) {
                        Text(livro.dadosLivro.titulo)
                            .font(
                                .system(
                                    size: 30,
                                    weight: .bold,
                                    design: .rounded
                                )
                            )
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)

                        if let subtitulo = livro.dadosLivro.subtitulo {
                            Text(subtitulo)
                                .font(.subheadline)
                                .foregroundStyle(
                                    .white.opacity(0.55)
                                )
                                .multilineTextAlignment(.center)
                        }

                        if let autores = livro.dadosLivro.autores {
                            Text(autores.joined(separator: ", "))
                                .font(.headline)
                                .foregroundStyle(
                                    .white.opacity(0.8)
                                )
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(.horizontal, 20)

                    if let nota = livro.dadosLivro.avaliacaoMedia {
                        HStack(spacing: 8) {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)

                            Text(
                                "\(nota, specifier: "%.1f")"
                            )
                            .fontWeight(.bold)
                            .foregroundStyle(.white)

                            if let quantidade =
                                livro.dadosLivro.quantidadeAvaliacoes {
                                Text(
                                    "(\(quantidade) avaliações)"
                                )
                                .foregroundStyle(
                                    .white.opacity(0.5)
                                )
                            }
                        }
                        .font(.subheadline)
                    }

                    HStack(spacing: 12) {

                        if let paginas =
                            livro.dadosLivro.quantidadePaginas {
                            VStack(spacing: 6) {
                                Image(systemName: "book.pages")
                                    .foregroundStyle(.white.opacity(0.7))

                                Text("\(paginas)")
                                    .font(.headline)
                                    .foregroundStyle(.white)

                                Text("páginas")
                                    .font(.caption)
                                    .foregroundStyle(
                                        .white.opacity(0.45)
                                    )
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                .white.opacity(0.07)
                            )
                            .clipShape(
                                RoundedRectangle(cornerRadius: 18)
                            )
                        }

                        if let data =
                            livro.dadosLivro.dataPublicacao {
                            VStack(spacing: 6) {
                                Image(systemName: "calendar")
                                    .foregroundStyle(.white.opacity(0.7))

                                Text(data)
                                    .font(.headline)
                                    .foregroundStyle(.white)

                                Text("publicação")
                                    .font(.caption)
                                    .foregroundStyle(
                                        .white.opacity(0.45)
                                    )
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                .white.opacity(0.07)
                            )
                            .clipShape(
                                RoundedRectangle(cornerRadius: 18)
                            )
                        }

                        if let idioma =
                            livro.dadosLivro.idioma {
                            VStack(spacing: 6) {
                                Image(systemName: "globe")
                                    .foregroundStyle(.white.opacity(0.7))

                                Text(idioma.uppercased())
                                    .font(.headline)
                                    .foregroundStyle(.white)

                                Text("idioma")
                                    .font(.caption)
                                    .foregroundStyle(
                                        .white.opacity(0.45)
                                    )
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                .white.opacity(0.07)
                            )
                            .clipShape(
                                RoundedRectangle(cornerRadius: 18)
                            )
                        }
                    }

                    if let editora = livro.dadosLivro.editora {
                        HStack {
                            Image(systemName: "building.2")
                                .foregroundStyle(.white.opacity(0.5))

                            Text(editora)
                                .font(.subheadline)
                                .foregroundStyle(
                                    .white.opacity(0.7)
                                )

                            Spacer()
                        }
                    }

                    if let descricao = livro.dadosLivro.descricao {
                        VStack(
                            alignment: .leading,
                            spacing: 12
                        ) {
                            Text("SINOPSE")
                                .font(.caption)
                                .fontWeight(.bold)
                                .tracking(2)
                                .foregroundStyle(
                                    .white.opacity(0.45)
                                )

                            Text(descricao)
                                .font(.body)
                                .foregroundStyle(
                                    .white.opacity(0.75)
                                )
                                .lineSpacing(5)
                        }
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .padding(20)
                        .background(
                            .white.opacity(0.06)
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 22)
                        )
                    }

                    if let link = livro.dadosLivro.linkPrevia,
                       let url = URL(string: link) {
                        Link(
                            destination: url
                        ) {
                            HStack {
                                Image(systemName: "book.fill")

                                Text("Ver no Google Books")
                                    .fontWeight(.bold)

                                Spacer()

                                Image(
                                    systemName: "arrow.up.right"
                                )
                            }
                            .foregroundStyle(.black)
                            .padding(18)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 18)
                            )
                        }
                    }
                }
                .padding(.horizontal, 22)
                .padding(.top, 15)
                .padding(.bottom, 35)
            }
        }
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        BookDetailView(
            livro: Livro(
                id: "1",
                dadosLivro: DadosLivro(
                    titulo: "Livro de Exemplo",
                    subtitulo: nil,
                    autores: ["Autor"],
                    editora: "Editora",
                    dataPublicacao: "2025",
                    descricao: "Descrição de exemplo do livro.",
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
