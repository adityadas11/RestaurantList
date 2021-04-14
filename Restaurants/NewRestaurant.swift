//
//  ContentView.swift
//  Restaurants
//
//  Created by Aditya Das on 3/17/21.
//

import SwiftUI
import Combine

struct NewRestaurant: View {
    
    @Environment(\.presentationMode) var presentation
    @ObservedObject var restData = RestaurantDataStore.shared
    @State private var isEmpty = false
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var showActionSheet = false
    @State var showImagePicker = false
    @State var sourceType:UIImagePickerController.SourceType = .camera
    
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
    @State var restaurantImage:UIImage?
    
    
    var body: some View {
        VStack{
            if restaurantImage != nil{
                Image(uiImage: restaurantImage!)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
                .listRowInsets(EdgeInsets())
            }
            else{
                Image(uiImage: UIImage(named: "default")!)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
                .listRowInsets(EdgeInsets())
            }
                            
            HStack {
                Spacer()
                Button(action: {
                    self.showActionSheet = true
                }) {
                    Text("Choose or take a picture")
                        .font(.subheadline)
                }.actionSheet(isPresented: $showActionSheet){
                    ActionSheet(title: Text("Add a picture of the restaurant"), message: nil, buttons: [
                        //Button1
                        
                        .default(Text("Camera"), action: {
                            self.showImagePicker = true
                            self.sourceType = .camera
                        }),
                        //Button2
                        .default(Text("Photo Library"), action: {
                            self.showImagePicker = true
                            self.sourceType = .photoLibrary
                        }),
                        
                        //Button3
                        .cancel()
                        
                    ])
                }.sheet(isPresented: $showImagePicker){
                    ImagePicker(image: self.$restaurantImage, showImagePicker: self.$showImagePicker, sourceType: self.sourceType)
                    
            }
                Spacer()
            }
        }
        
        Form{
            Section{
                VStack(alignment: .leading){
                    
                    
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
                                            .keyboardType(.numberPad)
                                            .onReceive(Just(self.restaurantPhone), perform: self.numericValidator)
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

                                            addRestaurant()
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
        }
        .background(Color.clear)
            }
    func numericValidator(newValue: String) {
        if newValue.range(of: "^\\d+$", options: .regularExpression) != nil {
            self.restaurantPhone = newValue
        } else if !self.restaurantPhone.isEmpty {
            self.restaurantPhone = String(newValue.prefix(self.restaurantPhone.count - 1))
        }
    }
    
    func addRestaurant(){
        let newRestaurant = Restaurant(context: viewContext)
        newRestaurant.id = UUID()
        newRestaurant.name = restaurantName
        newRestaurant.type = restaurantType
        newRestaurant.address = restaurantAddress
        newRestaurant.phone = restaurantPhone
        newRestaurant.detail = description
        newRestaurant.image = restaurantImage?.jpegData(compressionQuality: 1.0) ?? UIImage(named: "default")?.jpegData(compressionQuality: 1.0)
        saveContext()
    }
    
   
    
    private func saveContext(){
        do{
            try viewContext.save()
        }
        catch{
            let error = error as NSError
            fatalError("Unresolved error: \(error)")
        }
    }
  
}
            

struct NewRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        NewRestaurant()
    }
}

