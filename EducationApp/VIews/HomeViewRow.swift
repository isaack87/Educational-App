//
//  HomeViewRow.swift
//  EducationApp
//
//  Created by Isaac Kim on 3/27/23.
//

import SwiftUI

struct HomeViewRow: View {
    
    @EnvironmentObject var model: ContentModel
    
    var image: String
    var title: String
    var description: String
    var count: String
    var time: String
    var type: String
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .aspectRatio(CGSize(width: 335, height: 176), contentMode: .fit)
            
            
            HStack {
                
                Image(image)
                    .resizable()
                    .frame(width:116, height:116)
                    .clipShape(Circle())
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(title)
                        .bold()
                    Text(description)
                        .padding(.bottom, 20)
                        .font(.caption)
                    
                    HStack {
                        
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .frame(width:15, height:15)
                        Text("\(count) \(type)")
                            .font(Font.system(size:10))
                        
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width:15, height:15, alignment: .center)
                        Text(time)
                            .font(.caption)
                        
                    }
                }
                .padding(.leading, 20)
                
            }
            .padding(.horizontal, 20)
        }
        
    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(image: "swift", title: "Learn Swift", description: "some description 2", count: "11", time: "3 hours", type: "Lessons")
    }
}
