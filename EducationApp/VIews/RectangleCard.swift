//
//  RectangleCard.swift
//  EducationApp
//
//  Created by Isaac Kim on 3/29/23.
//

import SwiftUI

struct RectangleCard: View {
    
    var color = Color.white
    
    var body: some View {
        Rectangle()
            .foregroundColor(color)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

