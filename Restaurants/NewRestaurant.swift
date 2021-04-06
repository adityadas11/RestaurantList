//
//  ContentView.swift
//  Restaurants
//
//  Created by Aditya Das on 3/17/21.
//

import SwiftUI

struct NewRestaurant: View {
    
    @Environment(\.presentationMode) var presentation
    @ObservedObject var restData = RestaurantDataStore.shared
    @State private var isEmpty = false
   let restaurantPlaceholder: String = "Enter the restaurant name"
    let typePlaceholder: String = "Enter the restaurant type"
    let addressPlaceholder: String = "Enter the restaurant address"
    let phonePlaceholder: String = "Enter the restaurant phone"
    let descriptionPlaceholder: String = "Enter the restaurant description"
    
    @State var restaurantName:String = ""
    @State var restaurantType:String = ""
    @State var restaurantAddress:String = ""
    @State var restaurantPhone:String = ""
    @State var description:String = ""
    
    
    var body: some View {
        
        Form{
            Section{
                VStack(alignment: .leading){
                                    Image("default")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 200)
                                    .clipped()
                                    .listRowInsets(EdgeInsets())
                
                                    VStack(alignment: .leading) {
                                        Text("NAME").font(.headline)
                                        TextField("Enter restaurant name", text: $restaurantName)
                                                    .padding(.all)
                                            .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)).cornerRadius(10)
                                        Text("TYPE").font(.headline)
                                        TextField("Enter restaurant type", text: $restaurantType)
                                                    .padding(.all)
                                            .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)).cornerRadius(10)
                
                                        Text("ADDRESS").font(.headline)
                                        TextField("Enter restaurant address", text: $restaurantAddress)
                                                    .padding(.all)
                                            .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)).cornerRadius(10)
                
                                        Text("PHONE").font(.headline)
                                        TextField("Enter restaurant phone", text: $restaurantPhone)
                                                    .padding(.all)
                                            .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)).cornerRadius(10)
                
                                        Text("DESCRIPTION").font(.headline)
                                        TextField("Enter restaurant description", text: $description)
                                                    .padding(.all)
                                            .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)).cornerRadius(10)
                
                                    }
                                    .padding(.horizontal,15)
                
            }
                HStack {
                                        Spacer()
                                        Button(action: {
                                            if restaurantName == "" || restaurantType == "" || restaurantPhone == "" || restaurantAddress == "" || description == ""{
                                                isEmpty = true
                                                return
                                            }
                                            let lastEle = restData.dummyRestaurants.endIndex
                                            let newRest = RestaurantModel(id: restData.dummyRestaurants[lastEle-1].id + 1, name: restaurantName, type: restaurantType, address: restaurantAddress, phone: restaurantPhone, description: description,imageName: "default")
                                           restData.dummyRestaurants.append(newRest)
                                            self.presentation.wrappedValue.dismiss()
                
                                            }, label: {
                                                Text("Save")
                                                    .padding()
                                                    .background(Color.red)
                                                    .foregroundColor(Color.white).cornerRadius(16)
                                            }).alert(isPresented: $isEmpty, content: {
                                                Alert(title: Text("Alert"), message: Text("Fields cannot be empty"), dismissButton: .cancel())
                                            })
                                        Spacer()
                                    }
                
                
                
            }.padding(.top,20)
            .padding(.bottom,10)
                                .listRowInsets(EdgeInsets())
                                .navigationTitle("New Restaurant")
        }.background(Color.clear)
            }
}
            

struct NewRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        NewRestaurant()
    }
}

