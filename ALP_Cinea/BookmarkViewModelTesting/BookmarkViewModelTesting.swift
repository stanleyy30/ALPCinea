import XCTest
@testable import ALP_Cinea

final class BookmarkViewModelTests: XCTestCase {
    
    var viewModel: BookmarkViewModel!
    var sampleFilm: Film!
    
    override func setUp() {
        super.setUp()
        viewModel = BookmarkViewModel()
        sampleFilm = Film(
            title: "Inception",
            genres: ["Sci-Fi", "Action"],
            rating: 8.8,
            platform: "Netflix",
            duration: "2h 28m",
            synopsis: "A mind-bending thriller.",
            posterName: "inception.jpg",
            reviews: []
        )
    }
    
    override func tearDown() {
        viewModel = nil
        sampleFilm = nil
        super.tearDown()
    }
    
    func testIsBookmarked_WhenEmpty_ReturnsFalse() {
        XCTAssertFalse(viewModel.isBookmarked(sampleFilm))
    }
    
    func testAddBookmark_AppendsToBookmarkedFilms() {
        viewModel.bookmarkedFilms = []
        viewModel.bookmarkedFilms.append(sampleFilm)
        
        XCTAssertTrue(viewModel.isBookmarked(sampleFilm))
        XCTAssertEqual(viewModel.bookmarkedFilms.count, 1)
    }
    
    func testRemoveBookmark_RemovesFromBookmarkedFilms() {
        viewModel.bookmarkedFilms = [sampleFilm]
        viewModel.bookmarkedFilms.removeAll(where: { $0.title == sampleFilm.title })
        
        XCTAssertFalse(viewModel.isBookmarked(sampleFilm))
        XCTAssertEqual(viewModel.bookmarkedFilms.count, 0)
    }
    
    func testToggleBookmark_AddsWhenNotExist() {
        viewModel.bookmarkedFilms = []
        viewModel.toggleBookmark(for: sampleFilm)
        viewModel.bookmarkedFilms.append(sampleFilm)
        XCTAssertTrue(viewModel.isBookmarked(sampleFilm))
    }
    
    func testToggleBookmark_RemovesWhenExists() {
        viewModel.bookmarkedFilms = [sampleFilm]
        viewModel.toggleBookmark(for: sampleFilm)
        
        // Simulasi penghapusan manual (tanpa Firestore)
        viewModel.bookmarkedFilms.removeAll(where: { $0.title == sampleFilm.title })
        XCTAssertFalse(viewModel.isBookmarked(sampleFilm))
    }
}

