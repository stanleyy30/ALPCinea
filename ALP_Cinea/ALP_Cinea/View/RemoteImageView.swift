import SwiftUI

struct RemoteImageView: View {
    let imageURL: String

    var body: some View {
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(imageURL)")) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image.resizable().scaledToFill()
            case .failure:
                Image(systemName: "photo")
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    RemoteImageView(imageURL: "/8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg") // contoh poster_path dari TMDb
        .frame(width: 100, height: 140)
        .background(Color.black)
}
