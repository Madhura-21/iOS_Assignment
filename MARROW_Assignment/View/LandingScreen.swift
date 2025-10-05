import SwiftUI

struct LandingScreen: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("MedBook")
                    .bold()
                    .font(.largeTitle)
                Spacer()
                
                HStack(alignment: .center, spacing: 20) {
                    NavigationLink(destination: SignupScreen(), label: {
                        Text("Signup")
                            .foregroundStyle(Color.blue)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.white)
                            }
                    })
                    NavigationLink(destination: LoginScreen(), label: {
                        Text("Login")
                            .foregroundStyle(Color.blue)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.white)
                            }
                    })
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .background(Color.gray.opacity(0.3))
        }
    }
}

#Preview {
    LandingScreen()
}
