import SwiftUI
import PhotosUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            if let image = viewModel.profileImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.gray)
            }

            PhotosPicker("Ganti Foto", selection: $viewModel.imageSelection, matching: .images)
                .foregroundColor(.green)
                .onChange(of: viewModel.imageSelection) { _ in
                    viewModel.uploadProfileImage()
                }

            Text("Username: \(viewModel.username)")
            Text("Email: \(viewModel.email)")
                .foregroundColor(.gray)

            Button("Edit Profil") {
                viewModel.showUpdateProfile = true
            }
            .padding(.top)

            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.fetchUserData()
        }
        .sheet(isPresented: $viewModel.showUpdateProfile) {
            UpdateProfileView(viewModel: viewModel)
        }
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel())
}
