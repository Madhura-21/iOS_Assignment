import SwiftUI

struct SignupScreen: View {
    @StateObject var countriesVM = CountriesViewModel()
    @State private var email = ""
    @State private var password = ""
    @State var selectedCountry = ""
    @State private var isValidEmail = false
    @State private var isPasswordValid = false
    @State var isSigninSuccessfull = false
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Welcome")
                    .bold()
                    .font(.largeTitle)
                
                Text("sign up to continue")
                    .font(.title)
                    .padding(.bottom)
                
                TextField("Email", text: $email) { isChanged in
                    if ValidationViewModel().textFieldValidatorEmail(self.email) {
                        isValidEmail = true
                    } else {
                        isValidEmail = false
                    }
                }
                Divider()
                
                SecureField("Password", text: $password) {
                    isPasswordValid = ValidationViewModel().validatePassword(password)
                }
                Divider()
                
                HStack {
                    Image(systemName: "square")
                    Text("At least 8 characters")
                }
                .bold()
                
                HStack {
                    Image(systemName: "square")
                    Text("Must contain an uppercase letter")
                }
                .bold()
                
                HStack {
                    Image(systemName: "square")
                    Text("Contains a special character")
                }
                .bold()
                
                Picker("", selection: $selectedCountry) {
                    ForEach(countriesVM.countries, id: \.self) { country in
                        Text(country)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding(.bottom)
                
                Spacer()
                HStack {
                    NavigationLink(destination: HomeScreen(email: $email).navigationBarHidden(true), isActive: $isSigninSuccessfull) {
                        Button(action: {
                            print("clicked")
                            UserDefaults.standard.setValue(email, forKey: "Email")
                            KeychainWrapper.savePassword(account: email, data: password)
                            UserDefaults.standard.setValue(selectedCountry, forKey: "Country_\(email)")
                            isSigninSuccessfull = true
                        }, label: {
                            HStack {
                                Text("Let's go")
                                Image(systemName: "arrow.right")
                            }
                            .padding(.horizontal)
                            .foregroundStyle(Color.black)
                        })
                        .buttonStyle(.bordered)
                        .background(Color.teal)
//                        .disabled(isValidEmail && isPasswordValid ? true : false)
                        .opacity(isValidEmail && isPasswordValid ? 1 : 0.5)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding()
            .background(Color.gray.opacity(0.3))
            .task {
                email = ""
                password = ""
                await countriesVM.getCountries()
            }
        }
    }
}

#Preview {
    SignupScreen()
}
