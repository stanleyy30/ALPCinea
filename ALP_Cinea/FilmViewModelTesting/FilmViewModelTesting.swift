import XCTest
@testable import ALP_Cinea

final class FilmViewModelTests: XCTestCase {

    func testInitialFilmListIsEmpty() {
        let viewModel = FilmViewModel()
        XCTAssertTrue(viewModel.films.isEmpty, "Daftar film seharusnya kosong saat awal.")
    }

    func testFetchPopularFilmsAsync() {
        let expectation = XCTestExpectation(description: "Fetch film dari TMDb")
        let viewModel = FilmViewModel()

        viewModel.fetchPopularFilms()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            XCTAssertFalse(viewModel.films.isEmpty, "Film seharusnya terisi setelah fetch.")
            print("Film yang dimuat:", viewModel.films.map { $0.title })
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 6.0)
    }
}

