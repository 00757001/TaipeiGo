//
//  UserSpotView.swift
//  IOS_Final_00757001
//
//  Created by User04 on 2021/1/7.
//

import SwiftUI

struct UserSpotView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity:UserSpot.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \UserSpot.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<UserSpot>
    
    var body: some View {
        NavigationView{
            List {
                ForEach(items) { item in
                    NavigationLink(destination:
                        ModifySpot(item: item)
                            
                    ){
                        Text(item.name!)
                            .font(.system(size: 25))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("我的景點")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    HStack{
                        EditButton()
                            
                    }
                }
            }
        }
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ModifySpot: View{
    @ObservedObject var item: UserSpot
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @State private var showImage = false
    @State private var image: UIImage?
    @State private var title = ""
    @State private var description = ""
    @State private var modifySuccess = false
    
    var body: some View{
        VStack{
            if image != nil {
                Image(uiImage:image!)
                    .resizable()
                    .scaledToFit()
                        .frame(width:UIScreen.main.bounds.size.width*0.9)
            }
            Button(action:{
                self.showImage.toggle()
            }){
                Text("選擇其他照片")
                    .font(.system(size: 15))
            }
            .sheet(isPresented: $showImage, content: {
                ImagePickerController(selectImage: $image, showSelectPhoto: $showImage)
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
            Text("最後修改時間\(item.timestamp!,style: .date)")
        }
        .onAppear{
            title = item.name!
            description = item.content!
            loadImage()
        }
        .navigationBarItems(trailing: Button("儲存",action: {
            modifyItem()
        })
        .alert(isPresented: $modifySuccess) { () -> Alert in
            return Alert(title: Text("修改成功"), dismissButton:.default(Text("OK"), action: {
                presentationMode.wrappedValue.dismiss()
             }))
         }
        
        )
        
    }
    private func loadImage() {
        if let uiImage = UIImage(data: item.photo!){
            image = uiImage
        }
    }
    private func modifyItem() {
        withAnimation {
            item.name = title
            item.content = description
            item.timestamp = Date()
            if(image != nil){
                let newImage = image!.jpegData(compressionQuality: 0.80)
                item.photo = newImage
            }
            do {
                modifySuccess = true
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


struct UserSpotView_Previews: PreviewProvider {
    static var previews: some View {
        UserSpotView()
    }
}
