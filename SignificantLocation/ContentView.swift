//
//  ContentView.swift
//  SignificantLocation
//
//  Created by João Macedo on 04/05/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                    .padding(.all, 7.0)
                
                NavigationLink(destination: LocationsView()) {
                    Text("Visualizar localizações")
                }.padding(.all, 7.0)
                
                
                Button("Solicita permissão de notificação") {
                    NotificationHandler.instance.requestNotificationAuthorization()
                }.padding(.all, 7.0)
                
                Button("Solicita permissão de localização") {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }.padding(.all, 7.0)
                
                Button("Inicia registro de localização") {
                    UserLocationTracker.instance.initializeLocationTracker()
                }
                .padding(.all, 7.0)
                
                Button("Interromper registro de localização") {
                    UserLocationTracker.instance.finishLocationTracker()
                }.padding(.all, 7.0)
                
                Button("Limpar localizações coletadas") {
                    UserLocationTracker.instance.cleanLocations()
                }
                .padding(.all, 7.0)
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
