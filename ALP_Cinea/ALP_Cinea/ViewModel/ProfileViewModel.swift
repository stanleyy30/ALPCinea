import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftUI
import PhotosUI
import FirebaseStorage

class ProfileViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var profileImage: UIImage?
    @Published var imageSelection: PhotosPickerItem?
    @Published var showUpdateProfile = false

    private let db = Firestore.firestore()
    private let storage = Storage.storage()

    func fetchUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        db.collection("users").document(uid).getDocument { snapshot, error in
            if let data = snapshot?.data() {
                self.username = data["username"] as? String ?? ""
                self.email = data["email"] as? String ?? ""
            }
        }

        let imageRef = storage.reference().child("profileImages/\(uid).jpg")
        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, _ in
            if let data = data {
                self.profileImage = UIImage(data: data)
            }
        }
    }

    func uploadProfileImage() {
        guard let uid = Auth.auth().currentUser?.uid,
              let item = imageSelection else { return }

        item.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let data = data {
                        let ref = self.storage.reference().child("profileImages/\(uid).jpg")
                        ref.putData(data, metadata: nil) { _, _ in
                            self.profileImage = UIImage(data: data)
                        }
                    }
                case .failure(let error):
                    print("Upload error: \(error.localizedDescription)")
                }
            }
        }
    }

    func updateUserData(completion: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        db.collection("users").document(uid).updateData([
            "username": username,
            "email": email
        ]) { _ in
            if let user = Auth.auth().currentUser {
                user.updateEmail(to: self.email) { _ in
                    completion()
                }
            }
        }
    }
}
