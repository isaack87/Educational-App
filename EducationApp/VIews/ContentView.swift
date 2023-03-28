//
//  ContentView.swift
//  EducationApp
//
//  Created by Isaac Kim on 3/28/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                //confirm currentModule is set
                if (model.currentModel != nil) {
                    ForEach(0..<model.currentModel!.content.lessons.count) { index in
                        ContentViewRow(index: index)
                    }
                }
            }
            .padding(20)
            .navigationTitle("Learn \(model.currentModel?.category ?? "")")
            
        }
    }
}

