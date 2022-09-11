//
//  HomeView.swift
//  FreeApis
//
//  Created by Hasan Ali Şişeci on 11.09.2022.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ApiListView()
        }.navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
