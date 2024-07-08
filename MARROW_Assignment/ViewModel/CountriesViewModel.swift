import Foundation

@MainActor
class CountriesViewModel: ObservableObject {
    @Published var countryData: [String: Country] = [:]
    @Published var countries: [String] = []
    @Published var defaultCountry: String?
    
    func getCountries() async {
        if let url = URL(string: "https://api.first.org/data/v1/countries") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(for: urlRequest)
                    let responce = try JSONDecoder().decode(ResponseModel.self, from: data)
                    self.countryData = responce.data
                    for country in self.countryData {
                        self.countries.append(country.value.country)
                    }
//                    await getDefaultCountries()
                } catch {
                    debugPrint(error)
                    print("API call failed")
                }
            }
        }
    }
    
//    func getDefaultCountries() async {
//        if let url = URL(string: "http://ip-api.com/json)") {
//            var urlRequest = URLRequest(url: url)
//            urlRequest.httpMethod = "GET"
//            Task {
//                do {
//                    let (data, _) = try await URLSession.shared.data(for: urlRequest)
//                    let responce = try JSONDecoder().decode(DefaultCountry.self, from: data)
//                    self.defaultCountry = responce.country
//                } catch {
//                    debugPrint(error)
//                    print("API call failed")
//                }
//            }
//        }
//    }
}
