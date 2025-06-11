import Foundation

class FilmViewModel: ObservableObject {
    @Published var films: [Film] = []
    @Published var user = User()
    
    private let apiKey = "8e48742aa162dd912bed5c9bf4dddddc"
    private var genreDictionary: [Int: String] = [:]

    func fetchPopularFilms() {
        fetchGenres { [weak self] in
            guard let self = self else { return }
            guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(self.apiKey)&language=id-ID") else { return }

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(TMDbResponse.self, from: data) {
                        DispatchQueue.main.async {
                            self.films = decodedResponse.results.map { tmdb in
                                let genreNames = tmdb.genre_ids.compactMap { self.genreDictionary[$0] }

                                return Film(
                                    title: tmdb.title,
                                    genres: genreNames,
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
    
    @Published var upcomingFilms: [Film] = []

    func fetchUpcomingFilms() {
        fetchGenres { [weak self] in
            guard let self = self else { return }
            guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(self.apiKey)&language=id-ID&region=ID") else { return }

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(TMDbResponse.self, from: data) {
                        DispatchQueue.main.async {
                            self.upcomingFilms = decodedResponse.results.map { tmdb in
                                let genreNames = tmdb.genre_ids.compactMap { self.genreDictionary[$0] }

                                return Film(
                                    title: tmdb.title,
                                    genres: genreNames,
                                    rating: tmdb.vote_average,
                                    platform: "TMDb",
                                    duration: "Coming Soon",
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

    private func fetchGenres(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)&language=id-ID") else {
            completion()
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decoded = try? JSONDecoder().decode(TMDbGenreResponse.self, from: data) {
                    self.genreDictionary = Dictionary(uniqueKeysWithValues: decoded.genres.map { ($0.id, $0.name) })
                }
            }
            completion()
        }.resume()
    }
}
