import SwiftUI

struct BooksCarouselView: View {
    let categoria: CategoriaLivro
    
    @StateObject private var viewModel: BookViewModel
    
    init(categoria: CategoriaLivro) {
        self.categoria = categoria
        _viewModel = StateObject(
            wrappedValue: BookViewModel(categoria: categoria)
        )
    }
    
    var body: some View {
        Group {
            if viewModel.carregando {
                ProgressView("Carregando livros...")
            } else if let erro = viewModel.mensagemErro {
                VStack(spacing: 12) {
                    Text(erro)
                        .multilineTextAlignment(.center)
                    
                    Button("Tentar novamente") {
                        Task {
                            await viewModel.carregarLivros()
                        }
                    }
                }
                .padding()
            } else {
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(viewModel.livros) { livro in
                            NavigationLink(value: livro) {
                                BookCardView(book: livro)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(categoria.rawValue)
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
