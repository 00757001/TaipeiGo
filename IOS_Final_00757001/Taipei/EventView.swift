//
//  EventView.swift
//  IOS_Final_00757001
//
//  Created by User04 on 2020/12/30.
//

import SwiftUI

struct EventView: View{
    @State private var events = [EventItem]()
    let apiString: String
    func fetchEvents(){
        let url = URL(string: apiString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            if let data = data {
                do {
                    let eventResponse = try decoder.decode(EventResponse.self, from: data)
                    events = eventResponse.data

                } catch  {
                    print(error)
                }
                
            }
        }.resume()
    }
    var body: some View{
        List(events.indices, id: \.self, rowContent:{ (index) in
            Event(event: events[index])
        })
        .onAppear{
            if events.isEmpty{
                fetchEvents()
            }
        }
        
    }
}


struct Event: View{
    var event: EventItem
    @State private var showSheet = false
    
    
    var body: some View{
        HStack {
            if event.end == nil{
                Image(systemName: "speaker.2.fill")
                    .scaleEffect(2)
                    .frame(width: 40,height: 120)
            }
            else{
                Image(systemName: "calendar")
                    .scaleEffect(2)
                    .frame(width: 40,height: 120)
            }
            VStack(alignment:.leading) {
                Text(event.title)
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                    .minimumScaleFactor(.leastNonzeroMagnitude)
                    .frame(width: 290, height: 50, alignment: .leading)
                    
                HStack{
                    if event.end != nil{
                        Group {
                            Text("Due:")
                                .padding(0)
                            Text(event.end!,style: .date)
                                .padding(0)
                                .frame(width:155,alignment: .leading)
                            
                        }
                    }
                    Button(action:{
                        showSheet = true
                    }){
                        Text("前往")
                        .font(.system(size: 20))
                        .frame(width: 50, height:10)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(40)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .sheet(isPresented: $showSheet) {
                        WebView(urlString: event.url)
                    }
                    
                }.frame(height:50)
            }
            .frame(width:320)
            .frame(width: UIScreen.main.bounds.size.width*0.8, height: 130)
        }
        
        //.cornerRadius(20)
        
    }
}



struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(apiString: "https://www.travel.taipei/open-api/zh-tw/Events/News?page=1")
    }
}
