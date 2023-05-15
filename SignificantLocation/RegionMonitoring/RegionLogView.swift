//
//  RegionLogView.swift
//  SignificantLocation
//
//  Created by João Macedo on 15/05/23.
//

import SwiftUI

struct RegionLogView: View {
    var body: some View {
        VStack {
            Text("Registros de Regiões")
                .padding(.all, 16.0)
            
            Button("Limpar registros de monitoramento") {
                UserRegionMonitoring.instance.cleanRegionLogs()
            }
            .padding([.leading, .top, .bottom], 8.0)
            .padding(.bottom, 16.0)
            
            List(RegionLogDAO.instance.getRegionLogs()) { region in
                Text("Log moment: \(region.moment), Inside region: \(region.isInsideOfRegion ? "true" : "false")")
            }.padding(.all, 12)
        }
    }
}

struct RegionLogView_Previews: PreviewProvider {
    static var previews: some View {
        RegionLogView()
    }
}
