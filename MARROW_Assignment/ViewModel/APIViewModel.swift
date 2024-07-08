import Foundation

@MainActor
class APIViewModel: ObservableObject {
    @Published var serchedBooks: BooksResponseModel?
    @Published var limit = 10
    
    func performRequest(serchText: String) async {
        if let url = URL(string: "https://openlibrary.org/search.json?title=\(serchText)&limit=\(limit)") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(for: urlRequest)
                    let responce = try JSONDecoder().decode(BooksResponseModel.self, from: data)
                    self.serchedBooks = responce
                } catch {
                    debugPrint(error)
                    print("API call failed ")
                }
            }
        }
    }
}
