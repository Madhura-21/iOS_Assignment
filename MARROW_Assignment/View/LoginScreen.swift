import SwiftUI

struct LoginScreen: View {
    @State private var email = ""
    @State private var password = ""
    @State var isLoginSuccessfull = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Welcome")
                .bold()
                .font(.largeTitle)
            
            Text("sign up to continue")
                .font(.title)
                .padding(.bottom, 40)
            
            TextField("Email", text: $email)
            Divider()
            
            SecureField("Password", text: $password)
            Divider()
            Spacer()
            
            HStack {
                NavigationLink(destination: HomeScreen(email: $email).navigationBarHidden(true), isActive: $isLoginSuccessfull) {
                    Button(action: {
                        let email = UserDefaults.standard.object(forKey: "Email")
                        let password = KeychainWrapper.getPassword(account: email as! String)
                        if self.email == email as! String, self.password == password {
                            isLoginSuccessfull = true
                        }
                    }, label: {
                        HStack {
                            Text("Login")
                                .padding(.horizontal)
                                .foregroundStyle(Color.black)
                            Image(systemName: "arrow_forward")
                        }
                    })
                    .background(Color.white)
                    .buttonStyle(.bordered)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
        .background(Color.gray.opacity(0.3))
        .onAppear {
            email = ""
            password = ""
        }
    }
}

#Preview {
    LoginScreen()
}
