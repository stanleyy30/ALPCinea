//
//  ALP_Cinea_MACApp.swift
//  ALP_Cinea_MAC
//
//  Created by student on 11/06/25.
//

import SwiftUI

import Firebase
@main
struct ALP_Cinea_MACApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            MainView(viewModel: FilmViewModel())
        }
    }
}
