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
    @Published var currentModel: Module?
    var currentModuleIndex = 0
    
    
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
    
    func beginModule(moduleid:Int) {
        
        // find the index for this module id
        for index in 0..<modules.count {
            
            if (modules[index].id == moduleid) {
                
                // found matching result
                currentModuleIndex = index
                break
            }
        }
        
        // set current module
        currentModel = modules[currentModuleIndex]
        
    }
}
