//
//  ContentView.swift
//  AlertToastDemo
//
//  Created by Peace Cho on 10/14/22.
//

import AlertToast
import SwiftUI


struct ContentView: View {
    
    @EnvironmentObject var viewModel: AlertViewModel
    
    var body: some View {
        NavigationView{
            
           Group{
               NavigationLink("Move to Second View", destination: SecondView().environmentObject(viewModel))
           }
           
        }
        .toast(isPresenting: $viewModel.show){
            //Return AlertToast from ObservableObject
            viewModel.alertToast
        }
    }
}

struct SecondView: View{
    
    @EnvironmentObject var viewModel: AlertViewModel
    
    var body: some View{
        VStack{
            
             //Presenting alert from ObservableObject
            Button("Show Alert"){
                viewModel.show.toggle()
            }
            
            //You can also change the alert type, present
            //a different one and show (because of didSet)
            Button("Change Alert Type"){
                viewModel.alertToast = AlertToast(type: .complete(.green), title: "Completed!", subTitle: nil)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//Create an ObservableObject:
class AlertViewModel: ObservableObject{
    
    @Published var show = false
    @Published var alertToast = AlertToast(type: .regular, title: "SOME TITLE"){
        didSet{
            show.toggle()
        }
    }

}
