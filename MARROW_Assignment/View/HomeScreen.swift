import SwiftUI

struct HomeScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var apiViewModel = APIViewModel()
    @State private var text = ""
    @Binding var email: String
    @State private var isBookmarks = false
    @State var books: [Books] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "book.fill")
                Text("MedBook")
                Spacer()
                Image(systemName: "bookmark.fill")
                    .onTapGesture {
                        isBookmarks.toggle()
                        UserDafault().retriveDataFromUserDefaults(email: email)
                    }
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .renderingMode(.template)
                    .foregroundStyle(Color.red)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
            }
            .font(.largeTitle)
            .bold()
            Text(isBookmarks ? "Bookmarks" : "Which topic interests you today?")
                .font(.title)
            
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search for books", text: $text)
                    .onChange(of: text) {
                        Task {
                            await apiViewModel.performRequest(serchText: text)
                        }
                    }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 2)
                    .background(Color.gray.opacity(0.3))
            }
            if let books = isBookmarks ? UserDafault().retriveDataFromUserDefaults(email: email) : apiViewModel.serchedBooks?.docs {
                List(books, id: \.self) { book in
                    HStack {
                        AsyncImage(url: URL(string: "https://covers.openlibrary.org/b/id/<\(book.cover_i ?? 0)>-M.jpg")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        VStack(alignment: .leading) {
                            Text(book.title ?? "")
                                .bold()
                            HStack {
                                Text(book.author_name?.first ?? "")
                                    .foregroundStyle(Color.gray.opacity(0.5))
                                Image(systemName: "star.fill")
                                    .renderingMode(.template)
                                    .foregroundStyle(Color.yellow)
                                Text("\(book.ratings_average ?? 0.0, specifier: "%.2f")")
                                Image(systemName: "rectangle.stack.fill")
                                    .renderingMode(.template)
                                    .foregroundStyle(Color.yellow)
                                Text("\(book.ratings_count ?? 0)")
                            }
                            .font(.subheadline)
                        }
                    }
                    .swipeActions(edge: .trailing) {
                        Button {
                            UserDafault().saveDataToUserDefaults(data: book, email: email)
                        } label: {
                            Image(systemName: "bookmark")
                                .renderingMode(.template)
                                .foregroundStyle(Color.white)
                        }
                        .tint(Color.green)
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            UserDafault().removeDataFromUserDefaults(email: email)
                        } label: {
                            Image(systemName: "bookmark")
                                .renderingMode(.template)
                                .foregroundStyle(Color.white)
                        }
                        .tint(Color.red)
                    }
                    .background(Color.white)
                }
                .listStyle(.plain)
                .listRowSpacing(5)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            Spacer()
            
        }
        .padding()
        .background(Color.gray.opacity(0.3))
    }
}
