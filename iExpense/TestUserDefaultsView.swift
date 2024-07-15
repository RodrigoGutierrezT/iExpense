//
//  TestUserDefaultsView.swift
//  iExpense
//
//  Created by Rodrigo on 14-07-24.
//

import SwiftUI

struct User: Codable {
    let firstName: String
    let lastName: String
}

struct TestUserDefaultsView: View {
    @State private var tapCount = UserDefaults.standard.integer(forKey: "tap")
    @AppStorage("count") private var count = 0
    
    @State private var user = User(firstName: "Mario", lastName: "Bros")
    
    var body: some View {
        
        Spacer()
        
        Text("Tap count: \(tapCount)")
        Button("Tap me!") {
            tapCount += 1
            UserDefaults.standard.set(tapCount, forKey: "tap")
        }
        
        Text("App Storage Count: \(count)")
        Button("App storage tap!") {
            count += 1
        }
        
        Spacer()
        
        Button("Save User") {
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
        
        Spacer()
    }
}

#Preview {
    TestUserDefaultsView()
}
