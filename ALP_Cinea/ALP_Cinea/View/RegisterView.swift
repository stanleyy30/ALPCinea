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

            Spacer()
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
        .navigationTitle("Register")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Notice"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    RegisterView(viewModel: AuthViewModel())
}
