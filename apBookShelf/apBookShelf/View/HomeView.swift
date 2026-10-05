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

                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("BOOKSHELF")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .tracking(3)
                                        .foregroundStyle(
                                            .white.opacity(0.45)
                                        )

                                    Text("Sua biblioteca.")
                                        .font(
                                            .system(
                                                size: 38,
                                                weight: .bold,
                                                design: .rounded
                                            )
                                        )
                                        .foregroundStyle(.white)
                                }

                                Spacer()

                                Image(systemName: "books.vertical.fill")
                                    .font(
                                        .system(
                                            size: 25,
                                            weight: .bold
                                        )
                                    )
                                    .foregroundStyle(.white)
                                    .frame(width: 58, height: 58)
                                    .background(
                                        .white.opacity(0.1)
                                    )
                                    .clipShape(Circle())
                            }

                            Text("Escolha uma categoria e descubra sua próxima história.")
                                .font(.subheadline)
                                .foregroundStyle(
                                    .white.opacity(0.55)
                                )
                                .padding(.top, 5)
                        }

                        VStack(alignment: .leading, spacing: 15) {
                            Text("EXPLORE")
                                .font(.caption)
                                .fontWeight(.bold)
                                .tracking(2)
                                .foregroundStyle(
                                    .white.opacity(0.4)
                                )

                            ForEach(
                                CategoriaLivro.allCases
                            ) { categoria in

                                NavigationLink(
                                    value: categoria
                                ) {
                                    HStack(spacing: 18) {

                                        Image(
                                            systemName: categoria.icone
                                        )
                                        .font(
                                            .system(
                                                size: 24,
                                                weight: .semibold
                                            )
                                        )
                                        .foregroundStyle(.white)
                                        .frame(
                                            width: 52,
                                            height: 52
                                        )
                                        .background(
                                            .white.opacity(0.1)
                                        )
                                        .clipShape(
                                            RoundedRectangle(
                                                cornerRadius: 16
                                            )
                                        )

                                        VStack(
                                            alignment: .leading,
                                            spacing: 4
                                        ) {
                                            Text(categoria.rawValue)
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .foregroundStyle(.white)

                                            Text(
                                                "Explorar livros"
                                            )
                                            .font(.caption)
                                            .foregroundStyle(
                                                .white.opacity(0.45)
                                            )
                                        }

                                        Spacer()

                                        Image(
                                            systemName:
                                                "arrow.up.right"
                                        )
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundStyle(
                                            .white.opacity(0.5)
                                        )
                                    }
                                    .padding(14)
                                    .background(
                                        .white.opacity(0.06)
                                    )
                                    .clipShape(
                                        RoundedRectangle(
                                            cornerRadius: 22
                                        )
                                    )
                                    .overlay {
                                        RoundedRectangle(
                                            cornerRadius: 22
                                        )
                                        .stroke(
                                            .white.opacity(0.06),
                                            lineWidth: 1
                                        )
                                    }
                                }
                                .buttonStyle(.plain)
                            }
                        }

                        HStack(spacing: 12) {
                            Image(systemName: "sparkles")
                                .font(.headline)
                                .foregroundStyle(.white)

                            Text("Uma boa história pode mudar o seu dia.")
                                .font(.subheadline)
                                .italic()
                                .foregroundStyle(
                                    .white.opacity(0.5)
                                )
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 16)
                        .background(
                            .white.opacity(0.04)
                        )
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 20
                            )
                        )
                    }
                    .padding(.horizontal, 22)
                    .padding(.top, 15)
                    .padding(.bottom, 30)
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(
                for: CategoriaLivro.self
            ) { categoria in
                BooksCarouselView(
                    categoria: categoria
                )
            }
            .navigationDestination(
                for: Livro.self
            ) { livro in
                BookDetailView(
                    livro: livro
                )
            }
        }
    }
}

#Preview {
    HomeView()
}
