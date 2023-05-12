//
//  LocationsView.swift
//  SignificantLocation
//
//  Created by João Macedo on 12/05/23.
//

import SwiftUI

struct LocationsView: View {
    var body: some View {
        
        List(LocationDAO.instance.getLocations()) { location in
            Text("latitude: \(location.latitude), longitude: \(location.longitude)")
        }.padding(.all, 24)
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
    }
}
