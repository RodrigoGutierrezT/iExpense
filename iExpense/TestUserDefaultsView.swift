//
//  TestUserDefaultsView.swift
//  iExpense
//
//  Created by Rodrigo on 14-07-24.
//

import SwiftUI

struct TestUserDefaultsView: View {
    @State private var tapCount = UserDefaults.standard.integer(forKey: "tap")
    @AppStorage("count") private var count = 0
    
    var body: some View {
        Text("Tap count: \(tapCount)")
        Button("Tap me!") {
            tapCount += 1
            UserDefaults.standard.set(tapCount, forKey: "tap")
        }
        
        Text("App Storage Count: \(count)")
        Button("App storage tap!") {
            count += 1
        }
    }
}

#Preview {
    TestUserDefaultsView()
}
