import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel: AuthViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var isIpad: Bool {
        horizontalSizeClass == .regular
    }

    var body: some View {
        VStack(spacing: isIpad ? 32 : 24) {
            Spacer()

            Text("📝 Daftar Akun")
                .font(.system(size: isIpad ? 36 : 28, weight: .bold, design: .rounded))
                .foregroundColor(.green)

            VStack(spacing: isIpad ? 20 : 16) {
                TextField("Username", text: $viewModel.user.username)
                    .padding(isIpad ? 18 : 14)
                    .background(Color.white.opacity(0.05))
                    .cornerRadius(14)
                    .foregroundColor(.white)
                    .font(isIpad ? .title3 : .body)

                TextField("Email", text: $viewModel.user.email)
                    .padding(isIpad ? 18 : 14)
                    .background(Color.white.opacity(0.05))
                    .cornerRadius(14)
                    .foregroundColor(.white)
                    .autocapitalization(.none)
                    .font(isIpad ? .title3 : .body)

                SecureField("Password", text: $viewModel.user.password)
                    .padding(isIpad ? 18 : 14)
                    .background(Color.white.opacity(0.05))
                    .cornerRadius(14)
                    .foregroundColor(.white)
                    .font(isIpad ? .title3 : .body)

                SecureField("Konfirmasi Password", text: $viewModel.user.confirmPassword)
                    .padding(isIpad ? 18 : 14)
                    .background(Color.white.opacity(0.05))
                    .cornerRadius(14)
                    .foregroundColor(.white)
                    .font(isIpad ? .title3 : .body)
            }

            Button(action: {
                viewModel.register()
            }) {
                Text("Daftar")
                    .frame(maxWidth: .infinity)
                    .padding(isIpad ? 20 : 14)
                    .background(Color.green)
                    .cornerRadius(14)
                    .foregroundColor(.black)
                    .font(isIpad ? .title3 : .headline)
            }

            Button(action: {
                viewModel.showRegister = false
            }) {
                Text("Sudah punya akun? Masuk di sini")
                    .font(isIpad ? .body : .footnote)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding(isIpad ? 40 : 20)
        .background(Color.black.ignoresSafeArea())
    }
}

#Preview {
    RegisterView(viewModel: AuthViewModel())
        .previewDevice("iPad Pro (12.9-inch) (6th generation)")
}
