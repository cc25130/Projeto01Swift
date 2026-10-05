import SwiftUI

struct BooksCarouselView: View {
    let categoria: CategoriaLivro
    @State private var viewModel: BookViewModel

    init(categoria: CategoriaLivro) {
        self.categoria = categoria
        _viewModel = State(wrappedValue: BookViewModel(categoria: categoria))
    }

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

            if viewModel.carregando {
                ProgressView("Carregando...")
                    .tint(.white)
                    .foregroundStyle(.white.opacity(0.7))

            } else if viewModel.mensagemErro != nil {
                VStack(spacing: 16) {
                    Image(systemName: "book.closed")
                        .font(.system(size: 50))

                    Text("Não foi possível carregar os livros")
                        .font(.headline)
                        .multilineTextAlignment(.center)

                    Button("Tentar novamente") {
                        Task { await viewModel.carregarLivros() }
                    }
                    .font(.body.bold())
                    .foregroundStyle(.black)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(.white, in: Capsule())
                }
                .foregroundStyle(.white)
                .padding()

            } else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("BOOKSHELF")
                                    .font(.caption.bold())
                                    .foregroundStyle(.white.opacity(0.5))

                                Text(categoria.rawValue)
                                    .font(.system(size: 38, weight: .bold, design: .rounded))
                                    .foregroundStyle(.white)
                            }

                            Spacer()

                            Image(systemName: categoria.icone)
                                .font(.title2.bold())
                                .foregroundStyle(.white)
                                .frame(width: 52, height: 52)
                                .background(.white.opacity(0.12), in: Circle())
                        }

                        Text("Escolha uma história")
                            .font(.title3.weight(.medium))
                            .foregroundStyle(.white.opacity(0.65))

                        if !viewModel.livros.isEmpty {
                            ScrollViewReader { proxy in
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack(spacing: 20) {
                                        ForEach(0..<10000, id: \.self) { index in
                                            let livro = viewModel.livros[index % viewModel.livros.count]

                                            NavigationLink(value: livro) {
                                                VStack(alignment: .leading, spacing: 12) {
                                                    ZStack(alignment: .bottomLeading) {
                                                        AsyncImage(url: livro.dadosLivro.capaURL) { phase in
                                                            switch phase {
                                                            case .success(let image):
                                                                image.resizable().scaledToFill()
                                                            case .failure:
                                                                Image(systemName: "book.closed")
                                                                    .font(.system(size: 40))
                                                                    .foregroundStyle(.white.opacity(0.5))
                                                            default:
                                                                ProgressView().tint(.white)
                                                            }
                                                        }
                                                        .frame(width: 205, height: 300)
                                                        .background(.white.opacity(0.08))
                                                        .clipShape(RoundedRectangle(cornerRadius: 24))

                                                        LinearGradient(
                                                            colors: [.clear, .black.opacity(0.8)],
                                                            startPoint: .center,
                                                            endPoint: .bottom
                                                        )
                                                        .clipShape(RoundedRectangle(cornerRadius: 24))

                                                        VStack(alignment: .leading, spacing: 4) {
                                                            Text(livro.dadosLivro.titulo)
                                                                .font(.headline.bold())
                                                                .foregroundStyle(.white)
                                                                .lineLimit(2)

                                                            if let autor = livro.dadosLivro.autores?.first {
                                                                Text(autor)
                                                                    .font(.caption)
                                                                    .foregroundStyle(.white.opacity(0.75))
                                                                    .lineLimit(1)
                                                            }
                                                        }
                                                        .padding(16)
                                                    }
                                                }
                                                .frame(width: 205)
                                            }
                                            .buttonStyle(.plain)
                                            .id(index)
                                        }
                                    }
                                    .padding(.bottom, 10)
                                }
                                .onAppear {
                                    let meio = 5000 - (5000 % viewModel.livros.count)
                                    proxy.scrollTo(meio, anchor: .leading)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 22)
                    .padding(.top, 15)
                    .padding(.bottom, 30)
                }
            }
        }
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.carregarLivros()
        }
    }
}

#Preview {
    NavigationStack {
        BooksCarouselView(categoria: .fantasia)
    }
}
