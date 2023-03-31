//
//  TestView.swift
//  EducationApp
//
//  Created by Isaac Kim on 3/29/23.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model:ContentModel
    @State var selectedAnswerIndex:Int?
    @State var numCorrect = 0
    @State var submitted = false
    
    var body: some View {
        
        
        if model.currentQuestion != nil {
            
            VStack(alignment: .leading) {
                // Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                
                
                Text("\(numCorrect)")
                // Question
                CodeTextView()
                
                // Answers
                ScrollView {
                    VStack {
                        ForEach (0..<model.currentQuestion!.answers.count, id: \.self) { index in
                            Button {
                                // func in content model to track selected
                                selectedAnswerIndex = index
                            }
                        label: {
                            ZStack {
                                if submitted == false {
                                    RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                        .frame(height:48)
                                } else {
                                    //  user selected correct answer, box is green
                                    if (index == selectedAnswerIndex && index == model.currentQuestion?.correctIndex
                                        || index == model.currentQuestion!.correctIndex) {
                                        RectangleCard(color:  Color.green)
                                            .frame(height:48)
                                        
                                        // user selected wrong answer, box is red
                                    } else if (index == selectedAnswerIndex && index != model.currentQuestion!.correctIndex) {
                                        RectangleCard(color:  Color.red)
                                            .frame(height:48)
                                    } else {
                                        
                                        // box was not selected or not correct answer, leave unchanged to default white
                                        RectangleCard(color:  Color.white)
                                            .frame(height:48)
                                    }
                                }
                                Text(model.currentQuestion!.answers[index])
                            }
                        }
                        .disabled(submitted).foregroundColor(.black)
                        }
                    }
                    .padding()
                    .accentColor(.black)
                }
                
                //Submit Button
                
                Button {
                    
                    if (submitted) {
                        model.nextQuestion()
                        selectedAnswerIndex = nil
                        submitted = false
                    } else {
                        submitted = true
                        
                        if (selectedAnswerIndex == model.currentQuestion!.correctIndex) {
                            numCorrect += 1
                        }
                        
                        
                    }
                    
                } label: {
                    ZStack {
                        RectangleCard(color: .green).frame(height: 48)
                        Text(!submitted ? "submit" : "next")
                            .bold()
                            .foregroundColor(.white)
                        
                    }
                }
                .disabled(selectedAnswerIndex == nil)
                .accentColor(.black)
                .padding()
                
                
                
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
            
        } else {
            ProgressView()
        }
    }
    
    
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
