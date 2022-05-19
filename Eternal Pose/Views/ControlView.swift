//
//  ControlView.swift
//  Eternal Pose Markers
//
//  Created by Bigabiro Mpogazi Fabrice on 5/15/22.
//

import SwiftUI

struct ControlView: View {
    @Binding var isNavigating: Bool
    @Binding var showSearchControl: Bool
    @Binding var showMapControl: Bool
    
    var body: some View {
        VStack {
            navigationStatusButton(isNavigating: $isNavigating)
            Spacer()
            navigationControl(showSearchControl: $showSearchControl,
                              showMapControl: $showMapControl)
        }
    }
}

struct navigationStatusButton: View {
    @Binding var isNavigating: Bool
    
    var body: some View {
        HStack {
            Spacer()
            ZStack {
                Color.black.opacity(0.25)
                
                Button(action: {
                    print("Hello World")
                }) {
                    Image(systemName: "paperplane")
                        .font(.system(size: 25))
                        .foregroundColor(isNavigating ? .green : .white)
                        .buttonStyle(PlainButtonStyle())
                }
            }
            .frame(width: 50, height: 50)
            .cornerRadius(8.0)
        }
        .padding(.top, 55)
        .padding(.trailing, 10)
    }
}

struct navigationControl: View {
    @Binding var showSearchControl: Bool
    @Binding var showMapControl: Bool
    
    var body: some View {
        HStack {
            controlButton(systemIconImage: "magnifyingglass", action: self.searchButton, presentSheet: $showSearchControl)
            Spacer()
            controlButton(systemIconImage: "map.circle", action: self.mapButton, presentSheet: $showMapControl)
        }
        .frame(maxWidth: 500)
        .padding(30)
        .background(Color.black.opacity(0.25))
    }
    
    func searchButton() {
        self.showSearchControl.toggle()
    }
    
    func mapButton() {
        self.showMapControl.toggle()
    }
}

struct controlButton: View {
    let systemIconImage: String
    let action: () -> Void
    @Binding var presentSheet: Bool
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            Image(systemName: self.systemIconImage)
                .font(.system(size: 35))
                .foregroundColor(.white)
                .buttonStyle(PlainButtonStyle())
        }
        .frame(width: 55, height: 55)
        .sheet(isPresented: $presentSheet) {
            HStack {
                Text("")
            }
        }
    }
    
    func didDismiss() {}
}
