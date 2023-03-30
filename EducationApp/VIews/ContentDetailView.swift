//
//  ContentDetailView.swift
//  EducationApp
//
//  Created by Isaac Kim on 3/28/23.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    

    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        
        VStack {

           
            
            // only show video if valid URL
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))

            }
            
            //Text below video player
            CodeTextView()
            
            // Next lesson Button appears if there is next lesson
            if model.hasNextLesson() {
            Button(action: {
                model.nextLesson()
            }, label: {
                ZStack {
                    RectangleCard(color: Color.green)
                        .frame(height: 48)
                    
                    Text("Next Lesson: \(lesson?.title ?? "")")
                        .foregroundColor(Color.white)
                        .bold()
                }
                })
          
            } else {
                // show completed button
                Button(action: {
                    model.currentContentSelected = nil
                }, label: {
                    
                    ZStack {
                        RectangleCard(color: Color.green)
                            .frame(height: 48)
                        Text("Completed")
                            .foregroundColor(Color.white)
                            .bold()
                    }

                    })
                
                
            }
        }
        .padding()
        .navigationBarTitle(lesson?.title ?? "")

    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
