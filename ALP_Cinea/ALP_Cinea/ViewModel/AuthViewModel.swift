import Foundation

class AuthViewModel: ObservableObject {
    @Published var user = User()
    @Published var isLoggedIn = false
    @Published var showRegister = false

    func login() {
        if !user.email.isEmpty && !user.password.isEmpty {
            isLoggedIn = true
        }
    }

    func register() {
        if !user.username.isEmpty &&
            !user.email.isEmpty &&
            !user.password.isEmpty &&
            user.password == user.confirmPassword {
            print("Pendaftaran berhasil!")
        }
    }
}
