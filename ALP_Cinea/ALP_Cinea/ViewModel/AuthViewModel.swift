import Foundation

class AuthViewModel: ObservableObject {
    @Published var user = User()
    @Published var isLoggedIn = false
    @Published var showRegister = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func login() {
        if user.email.isEmpty || user.password.isEmpty {
            alertMessage = "Please fill in both email and password."
            showAlert = true
            return
        }
        
        if !isValidEmail(user.email) {
            alertMessage = "Please enter a valid email address."
            showAlert = true
            return
        }
        
        if user.email == "user@example.com" && user.password == "password123" {
            isLoggedIn = true
        } else {
            alertMessage = "Invalid email or password."
            showAlert = true
        }
    }
    
    func register() {
        if user.username.isEmpty || user.email.isEmpty || user.password.isEmpty || user.confirmPassword.isEmpty {
            alertMessage = "All fields are required."
            showAlert = true
            return
        }
        
        if !isValidEmail(user.email) {
            alertMessage = "Please enter a valid email address."
            showAlert = true
            return
        }
        
        if user.password.count < 6 {
            alertMessage = "Password must be at least 6 characters."
            showAlert = true
            return
        }
        
        if user.password != user.confirmPassword {
            alertMessage = "Passwords do not match."
            showAlert = true
            return
        }
        
        alertMessage = "Registration successful! You can now login."
        showAlert = true
        showRegister = false
        user = User()
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
}
