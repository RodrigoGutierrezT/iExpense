//
//  TestShowingView.swift
//  iExpense
//
//  Created by Rodrigo on 13-07-24.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    let name: String
    
    var body: some View {
        Text("Hi! \(name)")
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct TestShowingView: View {
    @State private var showingSecondView = false
    
    var body: some View {
        Button("Show second view") {
            showingSecondView.toggle()
        }
        .sheet(isPresented: $showingSecondView) {
            SecondView(name: "@GosuTyr")
        }
    }
}

#Preview {
    TestShowingView()
}
