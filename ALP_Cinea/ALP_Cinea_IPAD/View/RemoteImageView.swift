import SwiftUI

struct RemoteImageView: View {
    let imageURL: String
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        let width: CGFloat = sizeClass == .regular ? 180 : 100
        let height: CGFloat = sizeClass == .regular ? 260 : 140

        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(imageURL)")) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: width, height: height)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()
                    .cornerRadius(12)
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width * 0.5, height: height * 0.5)
                    .foregroundColor(.gray)
                    .frame(width: width, height: height)
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    RemoteImageView(imageURL: "/8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg")
        .background(Color.black)
        .previewDevice("iPad Pro (12.9-inch) (6th generation)")
}
