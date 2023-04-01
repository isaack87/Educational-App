//
//  ContentModel.swift
//  EducationApp
//
//  Created by Isaac Kim on 3/27/23.
//

import Foundation

class ContentModel: ObservableObject {
    
    // list of modules
    @Published var modules = [Module]()
    
    // Current Module selected
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    // current lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    // current question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    //current lesson explaination
    @Published var codeText = NSAttributedString()

    //current selected content and test
    @Published var currentContentSelected:Int?
    @Published var currentTestSelected:Int?
    
    var styleData: Data?
    
    
    init () {
        getLocalData()
    }
    
    // MARK: - Data Methods
    
    func getLocalData() {
        // Get a url path to the json file
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
        // Create a data object
        let jsonData = try Data(contentsOf: jsonUrl!)
            
        // Decode the data with a JSON decoder
        let jsonDecoder = JSONDecoder()
        let modules = try jsonDecoder.decode([Module].self, from: jsonData)
        // sets the published var in line 12
        self.modules = modules
    }
    catch {
        // error with getting data
        print(error)
    }
        
        // parse style data
        
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            
            // Read the file into a data onject
            let styleData = try Data(contentsOf: styleUrl!)
            self.styleData = styleData
        }
        catch {
            print("Couldn't parse local data")
        }
}
    
    // MARK: - Module Natvigation Methods
    
    func beginModule(_ moduleid:Int) {
        
        // find the index for this module id
        for index in 0..<modules.count {
            
            if (modules[index].id == moduleid) {
                
                // found matching result
                currentModuleIndex = index
                break
            }
        }
        
        // set current module
        currentModule = modules[currentModuleIndex]
        
    }
    
    func beginLesson(_ lessonIndex:Int) {
        
        // check that lesson index is within range of module lessons
        if (lessonIndex < currentModule!.content.lessons.count) {
            currentLessonIndex = lessonIndex
        } else {
            currentLessonIndex = 0
        }

        // set current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        codeText = addStyling(currentLesson!.explanation)
    }
    
    
    func hasNextLesson() -> Bool {
        if currentLessonIndex + 1 < currentModule!.content.lessons.count {
            return true
        } else {
            return false
        }
    }
    
    func nextLesson() {
        
        // takes you to next lesson
        currentLessonIndex += 1
        
        // check range to see if next lesson exist
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            // sets current lesson to next when button is clicked
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = addStyling(currentLesson!.explanation)
            
        } else {
            
            // reset lessons state if there is no next lessons
            currentLesson = nil
            currentLessonIndex = 0
        }
    }
    
    func nextQuestion() {
        currentQuestionIndex += 1
        if currentQuestionIndex < currentModule?.test.questions.count ?? 1 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            //set question content
            codeText = addStyling(currentQuestion!.content)

        } else {
            
           currentQuestionIndex = 0
            currentQuestion = nil
        }

    }
    
    func beginTest (_ moduleId:Int) {
        
        // set current module
        beginModule(moduleId)
        
        // set current question
        currentQuestionIndex = 0
        
        if currentModule?.test.questions.count ?? 0  > 0 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            //set question content
            codeText = addStyling(currentQuestion!.content)
            
        }
    }
    
    // MARK - calculate test score percentage
    
    func calculateTestResults (_ correct:Int) -> String {
        
        var result = ""
        
        // if current model is not set yet will not return error
        guard currentModule?.test.questions.count != nil else {
            return ""
        }
        
        let percentage = Double(correct) / Double(currentModule!.test.questions.count)
        
        if (percentage < 0.5) {
            result = "Keep Learning"
        } else if (percentage < 0.7) {
            result = "You Passed"
        } else {
            result = "You did Great!"
        }
        
        return result
    }
    
    // MARK - Code Styling
    
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        if (styleData != nil) {
            // Add styling data
            data.append(self.styleData!)
        }
        
        // Add html data
        data.append(Data(htmlString.utf8))
        
        // conter to attributed string
        do {
            let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                resultString = attributedString
        }
        catch {
            print(" Coult not convert html to attributed String")
        }
        
        return resultString
    }
}
