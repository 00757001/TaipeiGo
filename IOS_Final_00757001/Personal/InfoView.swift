//
//  InfoView.swift
//  IOS_Final_00757001
//
//  Created by User04 on 2021/1/6.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        NavigationView{
            List{
                Section(header: CustomHeader(name: "台北市政府")) {
                    NavigationLink(destination:WebView(urlString: "https://data.taipei")){
                        HStack{
                            Image("taipei")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text("台北市資料大平臺")
                                .font(.system(size: 22))
                        }
                    }
                    NavigationLink(destination:WebView(urlString: "https://www.travel.taipei/open-api")){
                        HStack{
                            Image("taipeitravel")
                                .resizable()
                                .frame(width: 60, height: 50)
                            Text("台北旅遊網Open API")
                                .font(.system(size: 22))
                        }
                    }
                }
                Section(header: CustomHeader(name: "中央氣象局")){
                    NavigationLink(destination:WebView(urlString: "https://opendata.cwb.gov.tw/index")){
                        HStack{
                            Image("cwb")
                                .resizable()
                                .frame(width: 70, height: 50)
                            Text("氣象資料開放平臺")
                                .font(.system(size: 22))
                        }
                    }
                }
            }
            .navigationTitle("API介紹")
        }
    }
}

struct CustomHeader: View {
    let name: String
    var body: some View {
        ZStack {
            Color(red: 84/255, green: 153/255, blue: 199/255).edgesIgnoringSafeArea(.all)
            HStack {
                Text(name)
                    .font(.system(size: 25))
                    .bold()
                    .foregroundColor(Color.black)
                Spacer()
            }
            .frame(width: 370)
            Spacer()
        }.frame(width:410, height: 33)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}


