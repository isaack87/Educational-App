//
//  QuizResultView.swift
//  EducationApp
//
//  Created by Isaac Kim on 4/1/23.
//

import SwiftUI

struct QuizResultView: View {
    
    @EnvironmentObject var model:ContentModel
    @State var correct:Int
    
    
    var body: some View {

        VStack {
            
            Spacer()
            Text("RESULTS OF YOUR QUIZ")
                .padding(.bottom, 50)
                .font(.title)
            
            
            Text(model.calculateTestResults(correct))
                .font(.callout)
                .bold()
                .padding(.bottom, 15)
            
 
            
            Text(" You got \(correct) out of \(model.currentModule?.test.questions.count ?? 0) correct.")
                .font(.callout)
                .padding(.bottom, 50)
            
            
            Spacer()
            Button {
                
                //setting this to nil just sends you back to the home screen
                // resets HomeView line 49 back to nil instead of the tag selected
                model.currentTestSelected = nil
                
            } label: {
                
                ZStack {
                    RectangleCard(color: .green)
                        .frame(height: 48)
                    
                    Text("Complete")
                        .foregroundColor(.white)
                        .bold()
                    
                }
            }
            
        }
        
        
    }
}


struct QuizResultView_Previews: PreviewProvider {
    static var previews: some View {
        QuizResultView(correct:2)
            .environmentObject(ContentModel())
    }
}


