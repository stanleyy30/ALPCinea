import Foundation

let sampleFilms = [
    Film(
        title: "Elara: The Lost Light",
        genre: "Sci-Fi",
        rating: 4.5,
        platform: "Netflix",
        duration: "2h 13m",
        synopsis: "In a distant galaxy, a rogue pilot uncovers a mysterious energy source that could save her planet.",
        posterName: "elara",
        reviews: [
            Review(username: "Alya", comment: "Visualnya luar biasa, jalan cerita juga menarik."),
            Review(username: "Rafi", comment: "Soundtrack-nya bikin merinding!")
        ]
    ),
    Film(
        title: "Velora",
        genre: "Drama",
        rating: 4.2,
        platform: "Disney+",
        duration: "1h 48m",
        synopsis: "Kisah menyentuh seorang pianis muda yang mencoba bangkit dari tragedi masa lalu.",
        posterName: "velora",
        reviews: [
            Review(username: "Nina", comment: "Emosional banget. Aktingnya keren."),
            Review(username: "Dian", comment: "Film yang bikin mikir dan ngerasa sekaligus.")
        ]
    )
]
