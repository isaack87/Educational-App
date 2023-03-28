//
//  ContentModel.swift
//  EducationApp
//
//  Created by Isaac Kim on 3/27/23.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    var styleData: Data?
    
    
    init () {
        getLocalData()
    }
         // Parse local json file
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
}
