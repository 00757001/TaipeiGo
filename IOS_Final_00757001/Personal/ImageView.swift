//
//  ImageView.swift
//  IOS_Final_00757001
//
//  Created by User04 on 2021/1/6.
//

import SwiftUI
import Alamofire

struct ImageView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showImage = false
    @State private var imageDisplay: UIImage?
    @State private var title = ""
    @State private var description = ""
    @State private var createSuccess = false
    var body: some View {
        VStack{
            if(imageDisplay == nil){
                Image(systemName: "photo")
                    .scaleEffect(5)
                    .frame(width: UIScreen.main.bounds.size.width*0.9, height:250)
                    .border(Color.black)
                    
            }
            else{
                Image(uiImage: imageDisplay!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.size.width*0.9, height:250 )
                    
            }
            
            Button(action:{
                self.showImage.toggle()
            }){
                Text("Select Image")
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showImage, content: {
                ImagePickerController(selectImage: $imageDisplay, showSelectPhoto: $showImage)
            })
            Spacer()
                .frame(height:50)
            HStack {
                Text("名稱：")
                    .font(.system(size: 20))
                TextField("",text: $title)
                    .border(Color.gray, width: 1)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: UIScreen.main.bounds.size.width*0.75, height: 50)
            }
            HStack {
                Text("描述：")
                    .font(.system(size: 20))
                TextEditor(text: $description)
                    .border(Color.gray, width: 1)
                    .frame(width: UIScreen.main.bounds.size.width*0.75, height: 150)
            }
            Spacer()
                .frame(height:50)
            HStack{
                Button(action:{
                    addSpot(name: title, content: description)
                }){
                    Text("建立景點")
                        .font(.system(size: 35))
                        .foregroundColor(.white)
                        .frame(width:200)
                        .padding(5)
                        .background(Color.green)
                        .cornerRadius(25)
                        
                }
                .alert(isPresented: $createSuccess) { () -> Alert in
                    return Alert(title: Text("建立成功"), dismissButton:.default(Text("OK"), action: {
                        presentationMode.wrappedValue.dismiss()
                     }))
                }
//                Spacer()
//                    .frame(width:50)
//                Button(action:{}){
//                    Text("建立活動")
//                        .font(.system(size: 25))
//                        .foregroundColor(.white)
//                        .padding(5)
//                        .background(Color.red)
//                        .cornerRadius(10)
//                }
            }
        }
    }
    private func addSpot(name: String,content: String) {
        withAnimation {
            let newItem = UserSpot(context: viewContext)
            newItem.timestamp = Date()
            newItem.name = name
            newItem.content = content
            if(imageDisplay != nil){
                let newImage = imageDisplay!.jpegData(compressionQuality: 0.80)
                newItem.photo = newImage
            }
            

            do {
                try viewContext.save()
                print("success")
                createSuccess = true
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
