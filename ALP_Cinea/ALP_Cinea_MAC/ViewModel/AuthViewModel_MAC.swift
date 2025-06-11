//
//  AuthViewModel_MAC.swift
//  ALP_Cinea_MAC
//
//  Created by student on 11/06/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel_MAC: ObservableObject {
    @Published var user = User()
    @Published var isLoggedIn = false
    @Published var showRegister = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var showResetPassword = false

    private let db = Firestore.firestore()

    func login() {
        if user.email.isEmpty || user.password.isEmpty {
            alertMessage = "Please fill in both email and password."
            showAlert = true
            return
        }

        Auth.auth().signIn(withEmail: user.email, password: user.password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                } else {
                    self.isLoggedIn = true
                }
            }
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

        if user.password != user.confirmPassword {
            alertMessage = "Passwords do not match."
            showAlert = true
            return
        }

        if user.password.count < 6 {
            alertMessage = "Password must be at least 6 characters long."
            showAlert = true
            return
        }

        Auth.auth().createUser(withEmail: user.email, password: user.password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                    return
                }

                guard let uid = result?.user.uid else {
                    self.alertMessage = "Failed to get user ID."
                    self.showAlert = true
                    return
                }

                let userData: [String: Any] = [
                    "username": self.user.username,
                    "email": self.user.email
                ]

                self.db.collection("users").document(uid).setData(userData) { error in
                    if let error = error {
                        self.alertMessage = "Failed to save user data: \(error.localizedDescription)"
                        self.showAlert = true
                    } else {
                        self.isLoggedIn = true
                        BookmarkViewModel().loadBookmarks()
                    }
                }
            }
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx =
        "(?:[a-zA-Z0-9!#$%\\&'*+/=?^_`{|}~-]+(?:\\." +
        "[a-zA-Z0-9!#$%\\&'*+/=?^_`{|}~-]+)*|\"" +
        "(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-" +
        "\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\" +
        "x0e-\\x7f])*\")@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-" +
        "]*[a-zA-Z0-9])?\\.)+[a-zA-Z]{2,}|" +
        "\\[(?:(2(5[0-5]|[0-4]\\d)|1\\d{2}|[1-9]?\\d))\\." +
        "(?:(2(5[0-5]|[0-4]\\d)|1\\d{2}|[1-9]?\\d))\\." +
        "(?:(2(5[0-5]|[0-4]\\d)|1\\d{2}|[1-9]?\\d))\\." +
        "(?:(2(5[0-5]|[0-4]\\d)|1\\d{2}|[1-9]?\\d))\\])"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
