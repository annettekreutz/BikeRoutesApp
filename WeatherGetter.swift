//http://www.globalnerdy.com/2016/04/02/how-to-build-an-ios-weather-app-in-swift-part-1-a-very-bare-bones-weather-app/

import Foundation

class WeatherGetter {
    
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
   // "YOUR API KEY HERE"
    private let openWeatherMapAPIKey = "a16c28496502e88d98118ad38aece9e8"
    var dataString = String()
    var daten = Data()
    
    func getWeather(city: String, callback: @escaping (String) -> ()) {
        
        // This is a pretty simple networking task, so the shared session will do.
       // let session = NSURLSession.sharedSession()

        let session = URLSession.shared

        let weatherRequestURL = URL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)")!
        
        
        // The data task retrieves the data.
       // let dataTask = session.dataTaskWithURL(weatherRequestURL) {
       //     (data: NSData?, response: NSUR	LResponse?, error: NSError?) in
        // The data task retrieves the data.
       // let dataTask = session.dataTask(with: weatherRequestURL, completionHandler)  {
       //     (data: Data?, response: URLResponse?, error: Error?) in
        let dataTask = session.dataTask(with: weatherRequestURL as URL) {
                (data: Data?, response: URLResponse?, error: Error?) in
                
            if let error = error {
                // Case 1: Error
                // We got some kind of error while trying to get data from the server.
                print("Error:\n\(error)")
            }
            else {
                // Case 2: Success
                // We got a response from the server!
                print("Raw data:\n\(data!)\n")
                let dataString = String(data: data!, encoding: .utf8)
                
                self.dataString = dataString!
                self.daten = data!
                callback(self.locateWetter())
                
            }
        } //as! (Data?, URLResponse?, Error?) -> Void
        
        // The data task is set up...launch it!
        dataTask.resume()
    }
    // see https://stackoverflow.com/questions/33939849/parsing-json-from-openweathermap-in-swift
//        func locateWetterxy() {
//        guard let data = daten as? Data else {return}
//        guard let result = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else{return}
//        

  //  }
    // see https://github.com/SwiftyJSON/SwiftyJSON
    //var wetter = String()
    
    // min and max temp from location
    // see https://stackoverflow.com/questions/33939849/parsing-json-from-openweathermap-in-swift
    // and see https://github.com/SwiftyJSON/SwiftyJSON
   public func locateWetter()-> String {
        guard let data = daten as? Data else {return ""}
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else{ return ""}
        var names = [String]()
        if let main = json?["main"] as? NSDictionary {
            print("Main existe")
            let without = Double(273.15)
            if let temp = main["temp_min"] {
              //  print("Temp existe")
                let value = (temp as! Double)
                names.append("min \(value - without) º")
            }
            if let temp = main["temp_max"] {
               // print("Temp existe")
                let value = (temp as! Double)
                names.append("max \(value - without) º")
            }
        }
        if let main = json?["wind"] as? NSDictionary {
            print("Wind existe")
            if let temp = main["speed"] {
                //  print("Temp existe")
                let value = (temp as! Double)
                names.append("Wind \(value) m/s")
            }
        }
        if let main = json?["clouds"] as? NSDictionary {
            print("Wolken existe")
            if let temp = main["all"] {
                //  print("Temp existe")
                let value = (temp as! Double)
                names.append("\(value) % bewölkt")
            }
        }
        var  wetter = String()
    
       // wetter = names.description
        wetter = names.joined(separator: ", ") as String
      //  var stringVarible = names as String
        print (wetter)
        return wetter
    }
}
