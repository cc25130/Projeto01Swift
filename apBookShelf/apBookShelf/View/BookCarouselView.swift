import SwiftUI

struct BooksCarouselView: View {
    let category: CategoriaLivro

    @State private var viewModel = BookViewModel()

    var body: some View {
        Group {
            if viewModel.isLoading {
                loadingView
            } else if let errorMessage = viewModel.errorMessage {
                errorView(message: errorMessage)
            } else if viewModel.books.isEmpty {
                emptyView
            } else {
                carouselView
            }
        }
        .navigationTitle(category.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Livro.self) { book in
            BookDetailView(book: book)
        }
        .task {
            await viewModel.fetchBooks(category: category)
        }
    }

    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.4)

            Text("Carregando livros...")
                .font(.headline)

            Text("Buscando informações na internet.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }

    private func errorView(message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "wifi.exclamationmark")
                .font(.system(size: 50))
                .foregroundStyle(.secondary)

            Text("Não foi possível carregar")
                .font(.title3)
                .fontWeight(.semibold)

            Text(message)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)

            Button("Tentar novamente") {
                Task {
                    await viewModel.fetchBooks(category: category)
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var emptyView: some View {
        VStack(spacing: 16) {
            Image(systemName: "book.closed")
                .font(.system(size: 50))
                .foregroundStyle(.secondary)

            Text("Nenhum livro encontrado")
                .font(.title3)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var carouselView: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Livros encontrados")
                    .font(.title2)
                    .fontWeight(.bold)

                Text("Deslize para explorar")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal)

            ScrollView(.horizontal) {
                LazyHStack(spacing: 20) {
                    ForEach(viewModel.books) { book in
                        NavigationLink(value: book) {
                            BookCardView(book: book)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .scrollTargetLayout()
                .padding(.horizontal)
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)

            Spacer()
        }
        .padding(.top)
    }
}

#Preview {
    NavigationStack {
        BooksCarouselView(category: .fantasia)
    }
}
