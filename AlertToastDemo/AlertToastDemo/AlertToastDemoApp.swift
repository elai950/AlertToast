//
//  AlertToastDemoApp.swift
//  AlertToastDemo
//
//  Created by Peace Cho on 10/14/22.
//

import SwiftUI

@main
struct AlertToastDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AlertViewModel())
        }
    }
}
