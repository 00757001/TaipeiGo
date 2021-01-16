//
//  MenuView.swift
//  IOS_Final_00757001
//
//  Created by User04 on 2020/12/24.
//

import SwiftUI

struct MenuView: View {
    @Binding var activePage: Int
    @Binding var showMenu: Bool
    var body: some View {
        VStack(alignment:.leading){
            HStack{
                Button(action:{
                    self.activePage = 0
                    self.showMenu = false
                }){
                    Image(systemName: "location")
                       
                    Text("景點")
                        .font(.headline)
                }.scaleEffect(1.3)
            }
            .padding(.top,100)
            .offset(x:-5)
            
            HStack{
                Button(action:{
                    self.activePage = 1
                    self.showMenu = false
                }){
                    Image(systemName: "speaker.2.fill")
                    Text("最新消息")
                        .font(.headline)
                }.scaleEffect(1.3)
            }
            .padding(.top,30)
            
            HStack{
                Button(action:{
                    self.activePage = 4
                    self.showMenu = false
                }){
                    Image(systemName: "cube.fill")
                    Text("活動展演")
                        .font(.headline)
                }.scaleEffect(1.3)
            }
            .padding(.top,30)
            
            HStack{
                Button(action:{
                    self.activePage = 3
                    self.showMenu = false
                }){
                    Image(systemName: "calendar")
                    Text("活動年曆")
                        .font(.headline)
                }.scaleEffect(1.3)
            }
            .padding(.top,30)
            
            HStack{
                Button(action:{
                    self.activePage = 2
                    self.showMenu = false
                }){
                    Image(systemName: "magnifyingglass")
                    Text("景點分類")
                        .font(.headline)
                }.scaleEffect(1.3)
            }
            .padding(.top,30)
            Spacer()
        }
        .offset(x:20)
        .padding()
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(activePage: .constant(0), showMenu: .constant(true))
    }
}
