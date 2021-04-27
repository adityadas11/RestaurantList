//
//  SingleRestaurantView.swift
//  Restaurants
//
//  Created by Aditya Das on 4/21/21.
//

import SwiftUI
import Combine



struct SingleRestaurantView: View {
    @State private var isEmpty = false
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @ObservedObject var restData = RestaurantDataStore.shared
    @State var showActionSheet = false
    @State var showImagePicker = false
    @State var sourceType:UIImagePickerController.SourceType = .camera
    
  
    
    
     let restaurantPlaceholder: String = "Enter the restaurant name"
     let typePlaceholder: String = "Enter the restaurant type"
     let addressPlaceholder: String = "Enter the restaurant address"
     let phonePlaceholder: String = "Enter the restaurant phone"
     let descriptionPlaceholder: String = "Enter the restaurant description"
     
    @State var restaurantID: UUID
    @State var restaurantName:String = ""
     @State var restaurantType:String = ""
     @State var restaurantAddress:String = ""
     @State var restaurantPhone:String = ""
     @State var description:String = ""
     @State var restaurantImage:UIImage?

    init(restObj: FetchedResults<Restaurant>.Element) {
        self.fetchedRest = restObj
        _restaurantID =  State(wrappedValue: restObj.id!)
        _restaurantName = State(wrappedValue: restObj.name!)
        _restaurantType = State(wrappedValue: restObj.type!)
        _restaurantAddress = State(wrappedValue: restObj.address!)
        _restaurantPhone = State(wrappedValue: restObj.phone!)
        _description = State(wrappedValue: restObj.detail!)
        _restaurantImage = State(wrappedValue: UIImage(data: restObj.image!))
    }
    
    var fetchedRest: FetchedResults<Restaurant>.Element
    
    var body: some View {
        VStack {
            if restaurantImage != nil{
                Image(uiImage: restaurantImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:250.0)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 5))
            }
            else{
                Image(uiImage: UIImage(named: "default")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:250.0)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 5))
            }
            
        }
        HStack {
            Spacer()
            Button(action: {
                self.showActionSheet = true
            }) {
                Text("Edit picture")
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
        Form{
            Section{
                VStack(alignment: .leading){
                    
                    
                                    VStack(alignment: .leading) {
                                        Text("NAME").font(.headline)
                                        TextField(restaurantPlaceholder,text: $restaurantName)
                                                    .padding(.all)
                                            .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)).cornerRadius(10)
                                        
                                        Text("TYPE").font(.headline)
                                        TextField(typePlaceholder, text: $restaurantType)
                                                    .padding(.all)
                                            .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)).cornerRadius(10)
                
                                        Text("ADDRESS").font(.headline)
                                        TextField(addressPlaceholder, text: $restaurantAddress)
                                                    .padding(.all)
                                            .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)).cornerRadius(10)
                
                                        Text("PHONE").font(.headline)
                                        TextField(phonePlaceholder, text: $restaurantPhone)
                                                    .padding(.all)
                                            .keyboardType(.numberPad)
                                            .onReceive(Just(self.restaurantPhone), perform: self.numericValidator)
                                            .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)).cornerRadius(10)
                
                                        Text("DESCRIPTION").font(.headline)
                                        TextField(descriptionPlaceholder, text: $description)
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
                                            updateRestaurant(fetchedRest: fetchedRest)
                                            self.presentation.wrappedValue.dismiss()
                
                                            }, label: {
                                                Text("Update")
                                                    .padding()
                                                    .background(Color.red)
                                                    .foregroundColor(Color.white).cornerRadius(16)
                                            })
                                        .buttonStyle(BorderlessButtonStyle())
                                        
                                        .alert(isPresented: $isEmpty, content: {
                                                Alert(title: Text("Alert"), message: Text("Fields cannot be empty"), dismissButton: .cancel())
                                            })
                                        Spacer()
                                    }
                
                
                
            }.padding(.top,20)
            .padding(.bottom,10)
                                .listRowInsets(EdgeInsets())
                                .navigationTitle("Edit Restaurant")
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
    func updateRestaurant(fetchedRest: FetchedResults<Restaurant>.Element){
        
        withAnimation{
            fetchedRest.id = restaurantID
            fetchedRest.name = restaurantName
            fetchedRest.type = restaurantType
            fetchedRest.address = restaurantAddress
            fetchedRest.phone = restaurantPhone
            fetchedRest.detail = description
            fetchedRest.image = restaurantImage?.jpegData(compressionQuality: 1.0) ?? UIImage(named: "default")?.jpegData(compressionQuality: 1.0)
            saveContext()
        }
        
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

struct SingleRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        let restu = Restaurant()
        SingleRestaurantView(restObj: restu)
    }
}
