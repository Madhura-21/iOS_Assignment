//
//  UserDafaults.swift
//  MARROW_Assignment
//
//  Created by GlobalLogic on 07/07/24.
//

import Foundation

struct UserDafault {
    func saveDataToUserDefaults(data: Books, email: String) {
        let defaults = UserDefaults.standard
        do {
            var books: [Books] = []
            books.append(data)
            let encodedData = try JSONEncoder().encode(books)
            defaults.set(encodedData, forKey: "bookMarks_\(email)")
        } catch {
            print("Error: \(error)")
        }
    }
    
    func removeDataFromUserDefaults(email: String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "bookMarks_\(email)")
    }
    
    func retriveDataFromUserDefaults(email: String) -> [Books]? {
        let defaults = UserDefaults.standard
        guard let savedData = defaults.object(forKey: "bookMarks_\(email)") as? Data else {
            return nil
        }
        do {
            let decodedData = try JSONDecoder().decode([Books].self, from: savedData)
            return decodedData
        } catch {
            print("Error decoding data: \(error)")
            // Handle error as needed
            return nil
        }
    }
}
