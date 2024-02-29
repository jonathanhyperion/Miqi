//
//  ContentView.swift
//  Miqi
//
//  Created by Elena Gordienko on 26.03.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            Text("This is Home Screen")
                .foregroundColor(Color("AccentText"))
                .font(.title.bold())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
