import SwiftUI

struct HomeView: View {

    var body: some View {
        NavigationStack {
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
                    VStack(alignment: .leading, spacing: 28) {

                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("BOOKSHELF")
                                        .font(.caption.bold())
                                        .foregroundStyle(.white.opacity(0.45))

                                    Text("Sua biblioteca")
                                        .font(.system(size: 38, weight: .bold, design: .rounded))
                                        .foregroundStyle(.white)
                                }

                                Spacer()

                                Image(systemName: "books.vertical.fill")
                                    .font(.title2.bold())
                                    .foregroundStyle(.white)
                                    .frame(width: 58, height: 58)
                                    .background(.white.opacity(0.1), in: Circle())
                            }

                            Text("Escolha uma categoria e descubra sua próxima história")
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.55))
                                .padding(.top, 4)
                        }

                        VStack(alignment: .leading, spacing: 15) {
                            Text("EXPLORE")
                                .font(.caption.bold())
                                .foregroundStyle(.white.opacity(0.4))

                            ForEach(CategoriaLivro.allCases) { categoria in
                                NavigationLink(value: categoria) {
                                    HStack(spacing: 16) {
                                        Image(systemName: categoria.icone)
                                            .font(.title3)
                                            .foregroundStyle(.white)
                                            .frame(width: 52, height: 52)
                                            .background(.white.opacity(0.1), in: RoundedRectangle(cornerRadius: 16))

                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(categoria.rawValue)
                                                .font(.headline.bold())
                                                .foregroundStyle(.white)

                                            Text("Explorar livros")
                                                .font(.caption)
                                                .foregroundStyle(.white.opacity(0.45))
                                        }

                                        Spacer()

                                        Image(systemName: "arrow.up.right")
                                            .font(.subheadline.bold())
                                            .foregroundStyle(.white.opacity(0.5))
                                    }
                                    .padding(14)
                                    .background(.white.opacity(0.06), in: RoundedRectangle(cornerRadius: 22))
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 16)
                        .background(.white.opacity(0.04), in: RoundedRectangle(cornerRadius: 20))
                    }
                    .padding(.horizontal, 22)
                    .padding(.top, 15)
                    .padding(.bottom, 30)
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
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
