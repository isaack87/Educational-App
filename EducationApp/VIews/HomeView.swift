////
//  ContentView.swift
//  EducationApp
//
//  Created by Isaac Kim on 3/27/23.
//

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
                                        model.beginModule(moduleid: module.id)
                            }),
                                label: {
                                HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count:String(module.content.lessons.count), time: module.content.time, type: "Lessons")
                                })
                            
                                           
                                //Test Card
                                HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: String(module.test.questions.count), time: String("\((module.test.time).prefix(6))s"), type: "Questions")
                        }
                    }
                }
                .accentColor(.black)
                .padding()
            }
        }
        .navigationTitle("Get Started")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
