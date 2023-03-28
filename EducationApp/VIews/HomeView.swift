//
//  ContentView.swift
//  EducationApp
//
//  Created by Isaac Kim on 3/27/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
       
        
        ScrollView {
            LazyVStack {
                ForEach(model.modules) { module in
                    //Learning Card
                    HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: String(module.content.lessons.count), time: module.content.time)
                    
                    //Test Card
                    HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: String(module.content.lessons.count), time: module.test.time)
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
