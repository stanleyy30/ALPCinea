import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Text("📝 Daftar Akun")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.green)

            VStack(spacing: 16) {
                TextField("Username", text: $viewModel.user.username)
                    .padding()
                    .background(Color.white.opacity(0.05))
                    .cornerRadius(12)
                    .foregroundColor(.white)

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

                SecureField("Konfirmasi Password", text: $viewModel.user.confirmPassword)
                    .padding()
                    .background(Color.white.opacity(0.05))
                    .cornerRadius(12)
                    .foregroundColor(.white)
            }

            Button(action: {
                viewModel.register()
            }) {
                Text("Daftar")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(12)
                    .foregroundColor(.black)
                    .font(.headline)
            }

            Button(action: {
                viewModel.showRegister = false
            }) {
                Text("Sudah punya akun? Masuk di sini")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
    }
}


#Preview {
    RegisterView(viewModel: AuthViewModel())
}
