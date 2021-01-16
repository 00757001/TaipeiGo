//
//  WeatherView.swift
//  IOS_Final_00757001
//
//  Created by User08 on 2020/12/31.
//
//2020-12-31 12:00:00
import SwiftUI

struct WeatherView: View {
    var locations = WeatherData()
    var body: some View {
        NavigationView{
            ZStack {
                Image("bg")
                    .resizable()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    if(locations.getCount() > 0){
                        WeatherItems()
                    }
                }
            }
            .navigationTitle("目前天氣")
        }
       
        .environmentObject(locations)
        .onAppear{
            locations.fetchWeather()
        }
    }
}


struct WeatherItems: View{
    @EnvironmentObject var locations: WeatherData
    @State private var now = Date()
    @State private var temper: Double = 0.0
    @State private var iconName: String = ""
    @State private var showAction = false
    var body: some View{
        if(locations[0].weatherElement.count > 0){
            Spacer()
                .frame(height:100)
            VStack(alignment: .leading, spacing:5) {
                Text("台北市")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)
                   
                Spacer()
                    .frame(height: 10)
                Text(locations[0].weatherElement[0].time[0].parameter.parameterName)
                    .font(.system(size:20))
                    .fontWeight(.light)
                    .offset(x:5)
                    .frame(maxWidth: .infinity, alignment: .center)
                   
        
                HStack {
                    Text("\(temper, specifier: "%.f")")//MaxT
                        .font(.system(size: 100))+Text("°c").font(.system(size: 50.0)).baselineOffset(50.0)
                    Image(iconName)//icon
                }.frame(maxWidth: .infinity, alignment: .center)
                
                HStack {
                    Image("rain")
                        .scaleEffect(0.5)
                        .frame(width:60)
                       
                    Text("  \(locations[0].weatherElement[1].time[0].parameter.parameterName)%")
                        .font(.system(size:30))//rain percent
                }.frame(maxWidth: .infinity, alignment: .center)
                
                HStack{
                    //Spacer()
                    Text("最後更新時間: \(now,style: .time)")
                        .font(.system(size: 25))
                        .offset(x:30)
                    Button(action:{
                        showAction.toggle()
                        now = Date()
                        locations.fetchWeather()
                    }){
                        Image("refresh")
                            .scaleEffect(0.3)
                            .rotationEffect(.degrees(self.showAction ? 360.0 : 0.0))
                            .animation(self.showAction ? Animation.linear(duration: 0.5).repeatCount(2, autoreverses: false) : nil)
                        
                    }
                }.frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height*0.8,alignment: .topLeading)
            .onAppear{
                temper = getTemp()
                iconName = getIcon()
                print(iconName)
            }
        }
    }
    func getTemp() -> Double{
        let min = locations[0].weatherElement[2].time[0].parameter.parameterName
        let max = locations[0].weatherElement[3].time[0].parameter.parameterName
        return Double(Int(min)! + Int(max)!) / 2.0
    }
    func getIcon() -> String{
        var weatherNum = 0
        let code = Int(locations[0].weatherElement[0].time[0].parameter.parameterValue!)!
        for (index,icon) in weatherType.enumerated(){
            if(icon.contains(code)){
                weatherNum = index
            }
        }
        let hour = Calendar.current.component(.hour, from: now)
        if(hour < 18 && hour >= 6){
            return weatherDayIcon[weatherNum]
        }
        else{
            return weatherNightIcon[weatherNum]
        }
    }
}
//
//struct weather: View {
//    @State private var icon = "null"
//    let weatherItem: status
//    let elementCode: Int
//    var body: some View{
//        VStack {
//            if(elementCode == 0){
//                Text(weatherItem.parameterName)
//            }
//            if(elementCode == 1){
//                Text(weatherItem.parameterName)
//            }
//            if(elementCode == 2){
//                Text(weatherItem.parameterName)
//            }
//            if(elementCode == 3){
//                Text(weatherItem.parameterName)
//            }
//        }
//        //Image("day-clear")
//    }
//}


struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
