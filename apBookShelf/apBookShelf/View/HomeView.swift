import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("BookShelf")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Descubra sua próxima leitura.")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }

                Text("Explore por categoria")
                    .font(.title2)
                    .fontWeight(.semibold)

                LazyVStack(spacing: 16) {
                    ForEach(CategoriaLivro.allCases, id: \.self) { category in
                        NavigationLink(value: category) {
                            CategoryCardView(category: category)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Biblioteca")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: CategoriaLivro.self) { category in
            BooksCarouselView(category: category)
        }
    }
}

struct CategoryCardView: View {
    let category: CategoriaLivro

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: category.icon)
                .font(.title2)
                .frame(width: 50, height: 50)
                .background(Color.blue.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 14))

            VStack(alignment: .leading, spacing: 4) {
                Text(category.rawValue)
                    .font(.headline)

                Text(category.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(radius: 3)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
