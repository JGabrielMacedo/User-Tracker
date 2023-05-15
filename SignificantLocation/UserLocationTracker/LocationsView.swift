//
//  LocationsView.swift
//  SignificantLocation
//
//  Created by João Macedo on 12/05/23.
//

import SwiftUI

struct LocationsView: View {
    var body: some View {
        VStack {
            Text("Registros de localização")
                .padding(.all, 16.0)
            
            Button("Limpar localizações coletadas") {
                UserLocationTracker.instance.cleanLocations()
            }
            .padding([.leading, .top, .bottom], 8.0)
            .padding(.bottom, 16.0)
            
            List(LocationDAO.instance.getLocations()) { location in
                Text("latitude: \(location.latitude), longitude: \(location.longitude), moment: \(location.moment)")
            }.padding(.all, 12)
            
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
    }
}
