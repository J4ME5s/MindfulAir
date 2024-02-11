import Foundation

var decodedData: AQIData?

struct AQIData: Codable {
    
    /*
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.overall_aqi = try container.decode(AQIData.self, forKey: .overall_aqi)
        self.PM10 = try container.decode(Pollutant.self, forKey: .PM10)
        self.PM25 = try container.decode(Pollutant.self, forKey: .PM25)
        self.NO2 = try container.decode(Pollutant.self, forKey: .NO2)
    }
     */
    
    let overall_aqi: Int
    let PM10: Int
    let PM25: Int
    let NO2: Int
    
    enum CodingKeys: String, CodingKey {
        case overall_aqi
        case PM10
        case PM25 = "PM2.5"
        case NO2
    }
    
}

struct Pollutant: Decodable {
    let concentration: Double
    let aqi: Int
}


class Api: ObservableObject {
    
    // removed -> AQIData
    func callAPI() {
        let city = "athens".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/airquality?city="+city!)!
        var request = URLRequest(url: url)
        request.setValue("i4mZtxvksERYWujKU0P5mQ==Esx3c6Xp68b5hNFA", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data else { return }
            /*
            let str = String(decoding: data, as: UTF8.self)
            let toJson = str.data(using: .utf8)!
             
            do {
                let jsonArr = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [Dictionary<String, Any>]
            } catch {
                print("An Error Occured")
            }
            */
            //print(String(data: data, encoding: .utf8)!)
            
            do {
                let aqiData = try? JSONDecoder().decode(AQIData.self, from: data)
                decodedData = aqiData
                //print(aqiData.PM10)
            } catch {
                print("An error occured")
            }
        }
        task.resume()
    }
    
    func decodeAPI(){
        guard let url = URL(string: "https://api.api-ninjas.com/v1/airquality?city=") else{return}
        
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            let decoder = JSONDecoder()
            
            if let data = data{
                do{
                    let tasks = try decoder.decode([AQIData].self, from: data)
                    tasks.forEach{ i in
                        print(i.PM10)
                    }
                }catch{
                    print(error)
                }
            }
        }
        task.resume()
        
    }
}
