import Foundation

let url = URL(string: "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWB-8B19FC97-0976-417F-8D6C-E55FDBBB8048&locationName=%E8%87%BA%E5%8C%97%E5%B8%82&elementName=Wx,PoP,MinT,MaxT")!
var request = URLRequest(url: url)
request.httpMethod = "GET"
request.setValue("application/json", forHTTPHeaderField: "Accept")

URLSession.shared.dataTask(with: request) { (data, response, error) in
    if let data = data,
       let content = String(data: data, encoding: .utf8) {
        print(content)
    }
}.resume()
