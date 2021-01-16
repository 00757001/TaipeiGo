//
//  SpotView.swift
//  IOS_Final_00757001
//
//  Created by User04 on 2020/12/30.
//

import SwiftUI

struct SpotView: View {
    let persistenceController = PersistenceController.shared
    @State private var spots = [SpotItem]()
    @State var searchText: String = ""
    let apiString: String
    let offsetNum: CGFloat
    func fetchSpots(){
        let url = URL(string: apiString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data, let spotResponse = try? decoder.decode(SpotResponse.self, from: data){
                DispatchQueue.main.async {
                    spots = spotResponse.data
                }
                
            }
        }.resume()
    }
    var body: some View{
        VStack {
            SearchBar(text: $searchText)
            List(spots.filter({searchText.isEmpty ? true : $0.name.contains(searchText)}), id: \.name, rowContent:{ (spot) in
                    Spot(spot: spot)
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }).offset(x:offsetNum)
        }
        .onAppear{
            if spots.isEmpty{
                fetchSpots()
            }
        }
    }
}


struct Spot: View{
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    var spot: SpotItem
    @State private var showSheet = false
    @State private var showAlert = false
    @State private var downloadImage = false
    var body: some View{
        VStack {
            HStack {
                Text(spot.name)
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                    .minimumScaleFactor(.leastNonzeroMagnitude)
                Button(action:{
                    showAlert = true
                    addItem(name: spot.name, urlString: spot.url)
                }){
                    Image(systemName: "bookmark.fill")
                        .foregroundColor(.blue)
                    
                }
                .alert(isPresented: $showAlert) { () -> Alert in
                    return Alert(title: Text("已加入收藏"))
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            if spot.images.count>0{
                NetworkImage(urlString: spot.images[0].src)
                    .scaledToFit()
                    .frame(width: 400)
                    .offset(x:5)
                    
            }
            if(spot.images.count==0){
                ZStack {
                    Rectangle()
                        .foregroundColor(.gray)
                    VStack {
                        Image(systemName: "photo")
                        Text("尚無照片")
                            .font(.system(size: 25))
                    }
                }
            }
            HStack{
                HStack{
                    Image("mappin")
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .scaleEffect(0.07)
                    Text(spot.distric)
                        .font(.system(size: 20))
                }.offset(x:-50)
                
                Button(action:{
                    showSheet = true
                }){
                    Text("前往")
                    .font(.system(size: 20))
                    .frame(width: 50, height:10)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(40)
                }
                .buttonStyle(PlainButtonStyle())
                .offset(x:80)
                .sheet(isPresented: $showSheet) {
                    WebView(urlString: spot.url)
                }
                
            }.frame(height:40)
        }
        
        .frame(width: UIScreen.main.bounds.size.width*0.8, height: 300)
        
        //.cornerRadius(20)
    }
    private func addItem(name: String,urlString: String) {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.name = name
            newItem.urlString = urlString

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


struct SpotView_Previews: PreviewProvider {
    static var previews: some View {
        SpotView(apiString: "https://www.travel.taipei/open-api/zh-tw/Attractions/All?page=2", offsetNum: 0)
    }
}
