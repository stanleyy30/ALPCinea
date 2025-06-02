import Foundation

class FilmViewModel: ObservableObject {
    @Published var films: [Film] = []

    private let apiKey = "8e48742aa162dd912bed5c9bf4dddddc"

    func fetchPopularFilms() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=id-ID") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(TMDbResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.films = decodedResponse.results.map { tmdb in
                            Film(
                                title: tmdb.title,
                                genre: "Drama",
                                rating: tmdb.vote_average,
                                platform: "TMDb",
                                duration: "2 jam",
                                synopsis: tmdb.overview,
                                posterName: tmdb.poster_path ?? "",
                                reviews: []
                            )
                        }
                    }
                }
            }
        }.resume()
    }
}
