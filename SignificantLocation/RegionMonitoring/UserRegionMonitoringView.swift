//
//  RegionUserMonitoring.swift
//  SignificantLocation
//
//  Created by João Macedo on 12/05/23.
//

import SwiftUI

struct UserRegionMonitoringView: View {
    
    @State var radius: String = ""
    
    var body: some View {
        VStack(alignment: .center){
            
            NavigationLink(destination: RegionLogView()) {
                Text("Visualizar registros")
            }.padding(.all, 8.0)

            Text("Você receberá uma notificação toda vez que sair ou entrar na regiao determinada, sendo o centro sua localização atual e as bordas o raio que for inserido abaixo")
                .padding(.all, 8.0)
            
            HStack(){
                Text("Raio: ")
                    .font(.headline)
                
                TextField("Radius", text: $radius)
                    .keyboardType(.numberPad)
                    .lineLimit(3)
            }
            .padding(.all, 24.0)
            
            Button("Iniciar monitoramento de região") {
                guard let radiusNumber = Double(radius) else { return }
                
                UserRegionMonitoring.instance.startRegionMonitoring(radius: radiusNumber)
            }
            .padding(.all, 8.0)
            
            Button("Interromper monitoramento de região") {
                UserRegionMonitoring.instance.stopMonitoringAllRegions()
            }
            .padding(.all, 8.0)

        }
    }
}

struct RegionUserMonitoring_Previews: PreviewProvider {
    static var previews: some View {
        UserRegionMonitoringView()
    }
}
