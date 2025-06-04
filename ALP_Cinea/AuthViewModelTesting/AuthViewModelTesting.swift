import XCTest
@testable import ALP_Cinea
import FirebaseAuth
import FirebaseFirestore

final class AuthViewModelTests: XCTestCase {

    var viewModel: AuthViewModel!

    override func setUp() {
        super.setUp()
        viewModel = AuthViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testEmptyLoginForm() {
        viewModel.user.email = ""
        viewModel.user.password = ""

        viewModel.login()

        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "Please fill in both email and password.")
    }

    func testRegisterFormEmptyFields() {
        viewModel.user.username = ""
        viewModel.user.email = ""
        viewModel.user.password = ""
        viewModel.user.confirmPassword = ""

        viewModel.register()

        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "All fields are required.")
    }

    func testInvalidEmailFormat() {
        viewModel.user.username = "Ken"
        viewModel.user.email = "invalidEmail"
        viewModel.user.password = "123456"
        viewModel.user.confirmPassword = "123456"

        viewModel.register()

        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "Please enter a valid email address.")
    }

    func testPasswordMismatch() {
        viewModel.user.username = "Ken"
        viewModel.user.email = "ken@example.com"
        viewModel.user.password = "123456"
        viewModel.user.confirmPassword = "654321"

        viewModel.register()

        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "Passwords do not match.")
    }

    func testPasswordTooShort() {
        viewModel.user.username = "Ken"
        viewModel.user.email = "ken@example.com"
        viewModel.user.password = "123"
        viewModel.user.confirmPassword = "123"

        viewModel.register()

        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "Password must be at least 6 characters long.")
    }

    func testResetPasswordMismatch() {
        viewModel.resetPassword(newPassword: "123456", confirmPassword: "654321")

        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "Password tidak cocok.")
    }

    func testResetPasswordTooShort() {
        viewModel.resetPassword(newPassword: "123", confirmPassword: "123")

        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "Password minimal 6 karakter.")
    }

    func testResetPasswordEmptyFields() {
        viewModel.resetPassword(newPassword: "", confirmPassword: "")

        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "Isi semua kolom.")
    }

    // Note: Untuk testing fungsi login dan register dengan Firebase, kamu bisa lakukan dengan menggunakan mocking
    // framework seperti Cuckoo atau inject dependency. Jika perlu saya bantu buat versi dengan mocking juga.
}
