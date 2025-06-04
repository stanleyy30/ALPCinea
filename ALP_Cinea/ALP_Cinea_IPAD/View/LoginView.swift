import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var showResetPassword = false

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    private var isIpad: Bool { horizontalSizeClass == .regular }

    var body: some View {
        NavigationView {
            VStack(spacing: isIpad ? 36 : 24) {
                Spacer()

                Text("🎬 Selamat Datang")
                    .font(.system(size: isIpad ? 42 : 28, weight: .bold, design: .rounded))
                    .foregroundColor(.green)

                VStack(spacing: isIpad ? 24 : 16) {
                    TextField("Email", text: $viewModel.user.email)
                        .padding(isIpad ? 20 : 16)
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(16)
                        .foregroundColor(.white)
                        .autocapitalization(.none)

                    SecureField("Password", text: $viewModel.user.password)
                        .padding(isIpad ? 20 : 16)
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(16)
                        .foregroundColor(.white)
                }

                Button(action: {
                    viewModel.login()
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding(isIpad ? 20 : 16)
                        .background(Color.green)
                        .cornerRadius(16)
                        .foregroundColor(.black)
                        .font(isIpad ? .title2 : .headline)
                }

                Button(action: {
                    viewModel.showRegister = true
                }) {
                    Text("Belum punya akun? Daftar di sini")
                        .font(isIpad ? .body : .footnote)
                        .foregroundColor(.gray)
                }

                Spacer()
            }
            .padding(isIpad ? 48 : 16)
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("Login")
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $viewModel.isLoggedIn) {
                HomeTabView()
            }
            .sheet(isPresented: $viewModel.showRegister) {
                RegisterView(viewModel: viewModel)
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview {
    LoginView()
        .previewDevice("iPad Pro (12.9-inch) (6th generation)")
}
