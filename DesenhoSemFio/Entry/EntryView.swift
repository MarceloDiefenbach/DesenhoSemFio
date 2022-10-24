//
//  EntryView.swift
//  DesenhoSemFio
//
//  Created by Marcelo Diefenbach on 23/10/22.
//

import SwiftUI

struct EntryView: View {
    
    @StateObject var viewModel: EntryViewModel = EntryViewModel()
    
    @State private var isShowingNextStep: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer ()
                    Text("Código da sua sala")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .font(.system(size: 16))
                    
                    Text("ANFJ")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .font(.system(size: 40).bold())
                    
                    Button(action: {
                        self.isShowingNextStep = true
                        viewModel.createRoom()
                    }, label: {
                        Text("Criar sala")
                        
                    }).buttonStyle(.borderedProminent)
                    
                    Spacer ()
                    
                }
                
            }.navigationBarHidden(true)
                .fullScreenCover(isPresented: $isShowingNextStep) {
                    CanvasView()
                    
                }
        }
    }
    
    func save(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView()
    }
}
