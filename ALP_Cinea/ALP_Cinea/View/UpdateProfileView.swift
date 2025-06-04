import SwiftUI

struct UpdateProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 16) {
            TextField("Username", text: $viewModel.username)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)

            TextField("Email", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)

            Button("Simpan Perubahan") {
                viewModel.updateUserData {
                    presentationMode.wrappedValue.dismiss()
                }
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
    UpdateProfileView(viewModel: ProfileViewModel())
}
