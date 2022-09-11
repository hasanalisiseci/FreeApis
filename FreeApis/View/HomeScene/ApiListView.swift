//
//  ApiListView.swift
//  FreeApis
//
//  Created by Hasan Ali Şişeci on 11.09.2022.
//

import SwiftUI

struct ApiListView: View {
    /// View model
    @ObservedObject var viewModel = ApiViewModel(service: Service())
    /// Variables
    @State private var selection = "All"

    var body: some View {
        ScrollView {
            LazyVStack {
                if viewModel.apiListIsCompleted ?? false {
                    if selection == "All" {
                        ForEach(viewModel.apiList!.entries, id: \.self) { model in
                            NavigationLink(destination: CommentViews(model: model)) {
                                ListItemView(model: model)
                            }
                        }
                    } else {
                        ForEach(viewModel.apiList!.entries, id: \.self) { model in
                            if model.category == selection {
                                NavigationLink(destination: CommentViews(model: model)) {
                                    ListItemView(model: model)
                                }
                            }
                        }
                    }
                } else {
                    ProgressView()
                }
            }
        }
        .navigationTitle("Free Api List")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Picker("Select Category", selection: $selection) {
                    ForEach(viewModel.categoryList, id: \.self) { category in
                        Text(category)
                            .bold().font(.title)
                    }
                }
                .pickerStyle(.menu)
            }
        }
    }
}

struct ApiListView_Previews: PreviewProvider {
    static var previews: some View {
        ApiListView()
    }
}
