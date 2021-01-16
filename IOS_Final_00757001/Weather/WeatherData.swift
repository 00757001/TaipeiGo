//
//  WeatherData.swift
//  IOS_Final_00757001
//
//  Created by User08 on 2021/1/1.
//

import Foundation
import SwiftUI

class WeatherData: ObservableObject {
    @AppStorage("Schedule") var weatherData: Data?
    
    @Published var weather = [locationItem](){
        didSet {
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(weather)
                weatherData = data
            } catch {
                
            }
        }
    }
    
    init() {
        if let weatherData = weatherData {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([locationItem].self,from: weatherData) {
                weather = decodedData
            }
        }
    }
    
    func getData(data: [locationItem]){
        self.weather = data
    }
    func getCount() -> Int{
        return self.weather.count
        
    }
    
    subscript(index: Int) -> locationItem{
        get{
            return self.weather[index]
        }
    }
    
    func fetchWeather(){
        let url = URL(string: "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWB-8B19FC97-0976-417F-8D6C-E55FDBBB8048&locationName=%E8%87%BA%E5%8C%97%E5%B8%82&elementName=Wx,PoP,MinT,MaxT")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            if let data = data {
                do {
                    let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                    //if(weatherResponse.records.location[0){
                    DispatchQueue.main.async {
                        self.getData(data: weatherResponse.records.location)
                    }  
                } catch  {
                    print(error)
                }
            }
        }.resume()
    }
}
