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
                if (model.currentModule != nil) {
                    ForEach(0..<model.currentModule!.content.lessons.count) { index in
                        
                        
                        NavigationLink(
                            destination:
                                ContentDetailView()
                                .onAppear(perform: {
                                    model.beginLesson(lessonIndex: index)
                                }),
                            label: {
                                ContentViewRow(index: index)
                            })
                    }
                }
            }
            .padding(20)
            .accentColor(.black)
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
            
        }
    }
}

