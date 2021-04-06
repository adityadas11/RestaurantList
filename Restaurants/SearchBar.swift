//
//  SearchBar.swift
//  Restaurants
//
//  Created by Aditya Das on 3/23/21.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text : String
    @State private var isEditing = false
    var body: some View {
        HStack{
            TextField("Search ... ", text: $text)
                .padding(7)
                .padding(.horizontal,25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(HStack{
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,  alignment: .leading)
                        .padding(.leading,8)
                    if isEditing{
                        Button(action: {
                            self.text = ""
                        }, label: {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing,8)
                        })
                    }
                })
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            if isEditing{
                Button {
                    self.isEditing = false
                    self.text = ""
                } label: {
                    Text("Cancel")
                    
                }.padding(.trailing,10)
                .transition(.move(edge: .trailing))
                .animation(.default)

            }
        }
        
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
