import SwiftUI

struct RemoteImageView: View {
    let imageURL: String

    var body: some View {
        GeometryReader { geometry in
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(imageURL)")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.5)
                        .foregroundColor(.gray)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    RemoteImageView(imageURL: "/8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg")
        .frame(width: 400, height: 600) 
        .background(Color.black)
        .previewLayout(.sizeThatFits)
}
