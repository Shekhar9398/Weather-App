import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()
    @State private var isDay: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // Top Weather Summary
                if let weather = viewModel.foreCastResponse {
                    ZStack {
                        if isDay {
                            LottieView(animationName: "sun3D")
                                .frame(width: 300, height: 300)
                        } else {
                            LottieView(animationName: "moon3D")
                                .frame(width: 300, height: 300)
                        }
                        
                        VStack(spacing: 4) {
                            Text(weather.location.name)
                                .font(MyFont.futura.size(24))
                                .shadow(color: .white, radius: 2)
                                .foregroundColor(.black)
                            
                            Text("\(Int(weather.current.temp_c))°C")
                                .font(MyFont.futura.size(22))
                                .shadow(color: .white, radius: 2)
                                .foregroundColor(.black)
                            
                            Text(weather.current.condition.text)
                                .font(MyFont.futura.size(18))
                                .shadow(color: .white, radius: 2)
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                } else {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .padding()
                }
                
                // Middle Weather Details
                if let weather = viewModel.foreCastResponse {
                    VStack(spacing: 12) {
                        HStack {
                            Text("Wind:")
                                .font(MyFont.futura.size(18))
                                .foregroundColor(.white)
                            Spacer()
                            Text("\(weather.current.wind_kph, specifier: "%.1f") kph \(weather.current.wind_dir)")
                                .font(MyFont.futura.size(16))
                                .foregroundColor(.white)
                        }
                        Divider().foregroundStyle(.white)
                        
                        HStack {
                            Text("Feels Like:")
                                .font(MyFont.futura.size(18))
                                .foregroundColor(.white)
                            Spacer()
                            Text("\(Int(weather.current.feelslike_c))°C")
                                .font(MyFont.futura.size(16))
                                .foregroundColor(.white)
                        }
                        Divider().foregroundStyle(.white)
                        
                        HStack {
                            Text("Humidity:")
                                .font(MyFont.futura.size(18))
                                .foregroundColor(.white)
                            Spacer()
                            Text("\(weather.current.humidity)%")
                                .font(MyFont.futura.size(16))
                                .foregroundColor(.white)
                        }
                        Divider().foregroundStyle(.white)
                        
                        HStack {
                            Text("UV Index:")
                                .font(MyFont.futura.size(18))
                                .foregroundColor(.white)
                            Spacer()
                            Text("\(weather.current.uv, specifier: "%.1f")")
                                .font(MyFont.futura.size(16))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    // Scrollable Forecast Section with Fade Mask
                    ZStack {
                        ScrollView {
                            VStack(spacing: 12) {
                                ForEach(weather.forecast.forecastday, id: \.date) { day in
                                    VStack(alignment: .center, spacing: 6) {
                                        Text(getWeekday(from: day.date))
                                            .font(MyFont.futura.size(20))
                                            .foregroundColor(.white)
                                        
                                        Text("Max: \(day.day.maxtemp_c, specifier: "%.1f")°C")
                                            .font(MyFont.futura.size(16))
                                            .foregroundColor(.white)
                                        
                                        Text("Min: \(day.day.mintemp_c, specifier: "%.1f")°C")
                                            .font(MyFont.futura.size(16))
                                            .foregroundColor(.white)
                                        
                                        Text("Condition: \(day.day.condition.text)")
                                            .font(MyFont.futura.size(16))
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    .frame(maxWidth: geometry.size.width * 0.85)
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(20)
                                }
                                .scrollTransition { content, phase in
                                    content
                                        .scaleEffect(phase.isIdentity ? 1 : 0.8)
                                        .offset(x: offset(for: phase))
                                }
                                
                            }
                            .padding(.vertical, 40)
                        }
                        .scrollIndicators(.hidden)
                        
                        // Apply fade mask at top and bottom
                        .mask(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color.clear, location: 0),
                                    .init(color: Color.white.opacity(1), location: 0.1),
                                    .init(color: Color.white.opacity(1), location: 0.9),
                                    .init(color: Color.clear, location: 1)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .ignoresSafeArea()
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isDay.toggle()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(
                Image(isDay ? "DesertNight" : "StaryNight")
                    .ignoresSafeArea()
            )
            .onAppear {
                viewModel.fetchForecastWeather(city: .pune)
            }
        }
    }
    
    // MARK: - Date Convert
    func getWeekday(from dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: dateString) else { return dateString }
        
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
    
    // MARK: - Offests for SrollTransition
    func offset(for phase: ScrollTransitionPhase) -> Double {
        switch phase {
        case .topLeading:
            return -200
        case .identity:
            return 0
        case .bottomTrailing:
            return 200
        }
    }
}

#Preview {
    ContentView(viewModel: WeatherViewModel())
}
