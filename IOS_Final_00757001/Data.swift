//
//  File.swift
//  IOS_Final_00757001
//
//  Created by User04 on 2020/12/24.
//

import Foundation

struct SpotResponse: Decodable{
    let total: Int
    let data: [SpotItem]
}

struct SpotItem: Decodable{
    let name: String
    let distric: String
    let url: String
    let images:[SpotImage]
}

struct SpotImage: Codable{
    let src: String
}

struct EventResponse: Codable{
    let total: Int
    let data: [EventItem]
}

struct EventItem: Codable{
    let url:String
    let title: String
    let end: Date?
}

let categories:[String] = ["養生溫泉","單車遊蹤","歷史建築","宗教信仰","藝文館所","戶外踏青","藍色水路","公共藝術","親子共遊","北北基景點"]
let categoriesLink:[String] = ["https://www.travel.taipei/open-api/zh-tw/Attractions/All?categoryIds=11&page=1",
                               "https://www.travel.taipei/open-api/zh-tw/Attractions/All?categoryIds=12&page=1",
                               "https://www.travel.taipei/open-api/zh-tw/Attractions/All?categoryIds=13&page=1",
                               "https://www.travel.taipei/open-api/zh-tw/Attractions/All?categoryIds=14&page=1",
                               "https://www.travel.taipei/open-api/zh-tw/Attractions/All?categoryIds=15&page=1",
                               "https://www.travel.taipei/open-api/zh-tw/Attractions/All?categoryIds=16&page=1",
                               "https://www.travel.taipei/open-api/zh-tw/Attractions/All?categoryIds=17&page=1",
                               "https://www.travel.taipei/open-api/zh-tw/Attractions/All?categoryIds=18&page=1",
                               "https://www.travel.taipei/open-api/zh-tw/Attractions/All?categoryIds=19&page=1",
                               "https://www.travel.taipei/open-api/zh-tw/Attractions/All?categoryIds=20&page=1"]

struct WeatherResponse: Codable {
    let records: RecordItem
}
struct RecordItem: Codable {
    
    let location:[locationItem]
}
struct locationItem: Codable {
    let weatherElement: [WeatherElement]
}
struct WeatherElement: Codable {
    let elementName: String
    let time: [timeStatus]
}
struct timeStatus: Codable {
    let startTime: Date
    let endTime: Date
    let parameter: status
}
struct status: Codable{
    let parameterName: String
    let parameterValue: String?
    let parameterUnit: String?
}

let weatherType: [[Int]] = [[15, 16, 17, 18, 21, 22, 33, 34, 35, 36, 41],
                            [1],
                            [25, 26, 27, 28],
                            [2, 3, 4, 5, 6, 7],
                            [24],
                            [8, 9, 10, 11, 12,13, 14, 19, 20, 29, 30,31, 32, 38, 39],
                            [23, 37, 42]
                           ]
let weatherDayIcon: [String] = ["day-thunderstorm","day-clear","day-cloudy-fog","day-cloudy","day-fog","day-partially-clear-with-rain","day-snowing",]
let weatherNightIcon: [String] = ["night-thunderstorm","night-clear","night-cloudy-fog","night-cloudy","night-fog","night-partially-clear-with-rain","night-snowing",]


enum ViewState {
    case favorite,image,info,userspot
}

struct UploadImageResult: Decodable {
    let data: ImageData
}
struct ImageData: Decodable {
    let link: URL?
}

//const weatherTypes = {
//isThunderstorm: [15, 16, 17, 18, 21, 22, 33, 34, 35, 36, 41],
//isClear: [1],
//isCloudyFog: [25, 26, 27, 28],
//isCloudy: [2, 3, 4, 5, 6, 7],
//isFog: [24],
//isPartiallyClearWithRain: [
//  8, 9, 10, 11, 12,
//  13, 14, 19, 20, 29, 30,
//  31, 32, 38, 39,
//],
//isSnowing: [23, 37, 42],
//};
