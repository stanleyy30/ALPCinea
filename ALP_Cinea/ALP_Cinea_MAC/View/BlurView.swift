//
//  BlurView.swift
//  ALP_Cinea_MAC
//
//  Created by student on 11/06/25.
//

import SwiftUI

#if os(iOS)
import UIKit

struct BlurView: View {
    let style: UIBlurEffect.Style

        init(style: UIBlurEffect.Style = .systemMaterial) {
            self.style = style
        }

        func makeUIView(context: Context) -> UIVisualEffectView {
            UIVisualEffectView(effect: UIBlurEffect(style: style))
        }

        func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
    }

    struct BlurView_Previews: PreviewProvider {
        static var previews: some View {
            BlurView(style: .systemUltraThinMaterialDark)
                .frame(width: 200, height: 200)
                .overlay(Text("iOS Blur").foregroundColor(.white))
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }

    #elseif os(macOS)

    struct BlurView: View {
        var body: some View {
            Rectangle()
                .fill(.ultraThinMaterial)
        }
    }

    struct BlurView_Previews: PreviewProvider {
        static var previews: some View {
            BlurView()
                .frame(width: 200, height: 200)
                .overlay(Text("macOS Blur").foregroundColor(.white))
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }

    #endif


