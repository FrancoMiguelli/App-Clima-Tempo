

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
    
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let urlManager = "https://api.openweathermap.org/data/2.5/weather?appid=b169d36f55ef229b8ceec6218296a530&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchManager(cityName: String) {
        let urlString = "\(urlManager)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func fetchManager(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(urlManager)&lat=\(latitude)&lon=\(longitude)"
        
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        //1. Create a URL
        if let url = URL(string: urlString) {
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData){
                        
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            
            //4. Start the task
            task.resume()
        }
        
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decoderData.weather[0].id
            let temp = decoderData.main.temp
            let cityName = decoderData.name
           
            let weather = WeatherModel(id: id, temp: temp, cityName: cityName)
            
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
   
}
