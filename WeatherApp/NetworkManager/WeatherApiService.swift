
import Foundation

enum Endpoint: String {
    case current = "/current.json"
    case forecast = "/forecast.json"
}

enum Days: String {
    case fiveDays = "5"
    case sevenDays = "7"
}

enum Cities: String {
    case pune = "Pune"
    case mumbai = "Mumbai"
}

class WeatherApiService {
    let baseUrl = "https://api.weatherapi.com/v1"
    let key = "?key=" + "16e05ecc5d6645829d561707252104"
    var endpoint = ""
    var q = "&q="
    var d = "&days="
    var url = ""
    
    init(){
        setUrl(endpoint: .current, location: .pune, days: .sevenDays)
    }
    
    func setUrl(endpoint: Endpoint, location: Cities, days: Days) {
        url = baseUrl + endpoint.rawValue + key + q + location.rawValue + d + days.rawValue
    }
}
