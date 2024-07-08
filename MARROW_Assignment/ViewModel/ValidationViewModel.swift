import Foundation


struct ValidationViewModel {
    
    func textFieldValidatorEmail(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
    
    func validatePassword(_ password: String) -> Bool {
        // Define regex patterns for validation
        let lengthRegex = "^.{8,}$"
        let uppercaseRegex = ".*[A-Z].*"
        let specialCharacterRegex = ".*[^A-Za-z0-9].*"
        
        // Validate using regular expressions
        let lengthTest = NSPredicate(format:"SELF MATCHES %@", lengthRegex)
        let uppercaseTest = NSPredicate(format:"SELF MATCHES %@", uppercaseRegex)
        let specialCharacterTest = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegex)
        
        // Check all conditions
        let isPasswordValid = lengthTest.evaluate(with: password) &&
        uppercaseTest.evaluate(with: password) &&
        specialCharacterTest.evaluate(with: password)
        
        return isPasswordValid
    }
}
