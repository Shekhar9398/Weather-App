import Foundation

class WeatherViewModel: ObservableObject {
    @Published var foreCastResponse: ForecastResponse?
    
    let service = WeatherApiService()

    func fetchForecastWeather(city: Cities) {
        // Debug: Print the city and URL being requested
        print("Fetching weather data for city: \(city.rawValue)")
        service.setUrl(endpoint: .forecast, location: city, days: .sevenDays)
        
        print("Requesting URL: \(service.url)")  // Debug: Print the constructed URL
        
        NetworkManager.shared.fetchData(urlString: service.url) { [weak self] (result: Result<ForecastResponse, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    // Debug: Print the fetched data count (forecast days)
                    print("Successfully fetched weather data. Forecast days count: \(weather.forecast.forecastday.count)")
                    self?.foreCastResponse = weather
                case .failure(let error):
                    // Debug: Print any error that occurs
                    print("Error fetching weather data: \(error)")
                }
            }
        }
    }
}
