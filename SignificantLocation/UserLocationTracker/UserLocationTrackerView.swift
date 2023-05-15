//
//  UserLocationTrackerView.swift
//  SignificantLocation
//
//  Created by João Macedo on 12/05/23.
//

import SwiftUI

struct UserLocationTrackerView: View {
    var body: some View {
        VStack {
            
            NavigationLink(destination: LocationsView()) {
                Text("Visualizar localizações")
            }.padding(.all, 8.0)
            
            Button("Inicia registro de localização") {
                UserLocationTracker.instance.initializeLocationTracker()
            }
            .padding(.all, 8.0)
            
            Button("Interromper registro de localização") {
                UserLocationTracker.instance.finishLocationTracker()
            }.padding(.all, 8.0)
        }
    }
}

struct UserLocationTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        UserLocationTrackerView()
    }
}
