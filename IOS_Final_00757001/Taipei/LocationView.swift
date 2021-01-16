//
//  LocationView.swift
//  IOS_Final_00757001
//
//  Created by User08 on 2020/12/21.
//

import SwiftUI

struct LocationView: View {
    @State private var showMenu = false
    @State private var activePage: Int = 0
    var body: some View {
        NavigationView {
            ZStack(alignment:.leading) {
                if self.activePage == 0{
                    SpotView(apiString: "https://www.travel.taipei/open-api/zh-tw/Attractions/All?page=1", offsetNum: 0)
                        .navigationBarTitle("最近更新景點",displayMode: .inline)
                        .padding(.top,0)
                }
                if self.activePage == 1{
                    EventView(apiString: "https://www.travel.taipei/open-api/zh-tw/Events/News?page=1")
                        .navigationBarTitle("最新活動與消息",displayMode: .inline)
                }
                if self.activePage == 2{
                    CategoryView()
                        .navigationBarTitle("分類景點",displayMode: .inline)
                }
                if self.activePage == 3{
                    EventView(apiString: "https://www.travel.taipei/open-api/zh-tw/Events/Calendar?page=1")
                        .navigationBarTitle("活動年曆",displayMode: .inline)
                }
                if self.activePage == 4{
                    EventView(apiString: "https://www.travel.taipei/open-api/zh-tw/Events/Activity?page=1")
                        .navigationBarTitle("活動展演",displayMode: .inline)
                }
                if self.showMenu{
                    MenuView(activePage :$activePage,showMenu:$showMenu)
                        .frame(width:UIScreen.main.bounds.size.width/2)
                        .transition(.move(edge: .leading))
                }
            }
            .gesture(
                DragGesture()
                    .onEnded{
                        if $0.translation.width < -100{
                            withAnimation{
                                self.showMenu.toggle()
                            }
                        }
                    }
            )
            .navigationBarItems(leading:(
                Button(action:{
                    withAnimation{
                        self.showMenu.toggle()
                    }
                }){
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                }
            ))
        }
        
        
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}



struct NetworkImage: View  {
    var urlString: String
    @State private var image = Image(systemName: "photo")
    @State var uimage: UIImage? = nil
    @State private var downloadImageOk = false
    
    func downLoad() {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data,response, error) in
                if let data = data,let uiImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        uimage = UIImage(data: data)
                        image = Image(uiImage: uiImage)
                        downloadImageOk = true
                    }
                    
                }
            }.resume()
        }
    }
    var body: some View {
        image
            .resizable()
            .contextMenu{
                Button(action:{
                    UIImageWriteToSavedPhotosAlbum(uimage!, nil, nil, nil)
                }){
                    Image(systemName: "square.and.arrow.down")
                    Text("下載")
                }
            }
        .onAppear {
            if downloadImageOk == false {
                downLoad()
            }
        }
    }
}




