import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var showResetPassword = false

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Spacer()

                Text("🎬 Selamat Datang")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.green)

                VStack(spacing: 16) {
                    TextField("Email", text: $viewModel.user.email)
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .autocapitalization(.none)

                    SecureField("Password", text: $viewModel.user.password)
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                }

                Button(action: {
                    viewModel.login()
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
                    showResetPassword = true
                }) {
                    Text("Lupa password?")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }

                Button(action: {
                    viewModel.showRegister = true
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
            .fullScreenCover(isPresented: $viewModel.isLoggedIn) {
                MainView(viewModel: FilmViewModel())
            }
            .sheet(isPresented: $viewModel.showRegister) {
                RegisterView(viewModel: viewModel)
            }
            .sheet(isPresented: $showResetPassword) {
                ForgotPasswordView(viewModel: viewModel)
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview {
    LoginView()
}
