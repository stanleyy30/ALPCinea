import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var showRegister = false

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Spacer()

                Text("🎬 Selamat Datang")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.green)

                VStack(spacing: 16) {
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .autocapitalization(.none)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                }

                Button(action: {
                    if !email.isEmpty && !password.isEmpty {
                        isLoggedIn = true
                    }
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(12)
                        .foregroundColor(.black)
                        .font(.headline)
                }

                Button(action: {
                    showRegister = true
                }) {
                    Text("Belum punya akun? Daftar di sini")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }

                Spacer()
            }
            .padding()
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("Login")
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $isLoggedIn) {
                MainView()
            }
            .sheet(isPresented: $showRegister) {
                RegisterView()
            }
        }
    }
}

#Preview {
    LoginView()
}
