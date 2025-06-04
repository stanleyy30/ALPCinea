import SwiftUI

struct ForgotPasswordView: View {
    @ObservedObject var viewModel: AuthViewModel
    @State private var newPassword = ""
    @State private var confirmNewPassword = ""

    var body: some View {
        VStack(spacing: 16) {
            SecureField("Password Baru", text: $newPassword)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)

            SecureField("Konfirmasi Password Baru", text: $confirmNewPassword)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)

            Button("Ubah Password") {
                viewModel.resetPassword(newPassword: newPassword, confirmPassword: confirmNewPassword)
            }
            .padding()
            .background(Color.green)
            .cornerRadius(12)
            .foregroundColor(.white)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ForgotPasswordView(viewModel: AuthViewModel())
}
