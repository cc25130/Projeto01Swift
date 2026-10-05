import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("BookShelf")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("O que você quer ler hoje?")
                        .font(.title3)
                    
                    ForEach(CategoriaLivro.allCases) { categoria in
                        NavigationLink(value: categoria) {
                            HStack(spacing: 16) {
                                Image(systemName: categoria.icone)
                                    .font(.title2)
                                    .frame(width: 40)
                                
                                Text(categoria.rawValue)
                                    .font(.headline)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .background(.quaternary.opacity(0.5))
                            .clipShape(
                                RoundedRectangle(cornerRadius: 14)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("Início")
            .navigationDestination(for: CategoriaLivro.self) { categoria in
                BooksCarouselView(categoria: categoria)
            }
            .navigationDestination(for: Livro.self) { livro in
                BookDetailView(livro: livro)
            }
        }
    }
}

#Preview {
    HomeView()
}
