////
//  ContentView.swift
//  EducationApp
//
//  Created by Isaac Kim on 3/27/23.
// $ binding allows read and write through published

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
       
        NavigationView {
            VStack(alignment: .leading) {
            Text("What do you want to do today?")
                    .padding(.leading, 20)
            ScrollView {
                LazyVStack {
                    
                    ForEach(model.modules) { module in
                        
                        VStack(spacing: 20) {
                            
                            //Learning Card
                            NavigationLink(
                                destination:
                                    ContentView()
                                    .onAppear(perform: {
                                        model.beginModule(module.id)
                                        print(model.currentContentSelected)
                                }),
                                tag: module.id,
                                selection: $model.currentContentSelected,
                                label: {
                                HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count:String(module.content.lessons.count), time: module.content.time, type: "Lessons")
                                })
                            
                            //Test Card
                            NavigationLink(
                                destination:
                                    TestView()
                                    .onAppear(perform: {
                                        model.beginTest(module.id)
                                }),
                                tag: module.id,
                                selection: $model.currentTestSelected,
                                label: {
                                HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: String(module.test.questions.count), time: String("\((module.test.time).prefix(6))s"), type: "Questions")
                                })
                        }
                    }
                }
                .accentColor(.black)
                .padding()
            }
        }
            .padding()
        .navigationTitle("Get Started")
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
