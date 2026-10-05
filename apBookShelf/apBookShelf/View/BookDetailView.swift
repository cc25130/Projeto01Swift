import SwiftUI

struct BookDetailView: View {
    let livro: Livro
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: livro.dadosLivro.capaURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.quaternary)
                        .frame(width: 180, height: 260)
                        .overlay {
                            Image(systemName: "book.closed")
                                .font(.largeTitle)
                        }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 280)
                
                Text(livro.dadosLivro.titulo)
                    .font(.title)
                    .fontWeight(.bold)
                
                if let subtitulo = livro.dadosLivro.subtitulo {
                    Text(subtitulo)
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                
                if let autores = livro.dadosLivro.autores {
                    Text("Autor(es): \(autores.joined(separator: ", "))")
                }
                
                if let editora = livro.dadosLivro.editora {
                    Text("Editora: \(editora)")
                }
                
                if let data = livro.dadosLivro.dataPublicacao {
                    Text("Publicação: \(data)")
                }
                
                if let paginas = livro.dadosLivro.quantidadePaginas {
                    Text("Páginas: \(paginas)")
                }
                
                if let nota = livro.dadosLivro.avaliacaoMedia {
                    Text("Nota média: \(nota, specifier: "%.1f")")
                }
                
                if let descricao = livro.dadosLivro.descricao {
                    Text("Sinopse")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text(descricao)
                        .textSelection(.enabled)
                }
                
                if let link = livro.dadosLivro.linkPrevia,
                   let url = URL(string: link) {
                    Link("Visualizar no Google Books", destination: url)
                        .fontWeight(.semibold)
                }
            }
            .padding()
        }
        .navigationTitle("Detalhes")
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
