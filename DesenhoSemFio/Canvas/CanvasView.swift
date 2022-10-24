//
//  CanvasView.swift
//  DesenhoSemFio
//
//  Created by Marcelo Diefenbach on 17/10/22.
//

import SwiftUI

struct CanvasView: View {
    
    @StateObject var viewModel: CanvasViewModel = CanvasViewModel()
    
    @State private var image: UIImage?
    @State private var isShowingNextStep: Bool = false
    
    var CanvasView: some View {
        Canvas { contex, size in
            
            for line in viewModel.lines {
                var path = Path()
                path.addLines(line.points)
                contex.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
            }
            
        }.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onChanged({value in
                viewModel.addLine(value: value)
            })
            .onEnded({ value in
                viewModel.cleanLineToRestart()
            })
        ).frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                CanvasView
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.viewModel.cleanCanvas()
                            
                        }, label: {
                            Image(systemName: "xmark.circle.fill").foregroundColor(.black)
                                .font(.system(size: 30))
                            
                        })
                    }
                    Spacer()
                    
                }.padding(.top, UIScreen.main.bounds.height*0.05)
                    .padding(.trailing, 20)
                
                VStack {
                    Text(viewModel.drawThis)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .font(.system(size: 16))
                    
                    Text(viewModel.thingToDraw)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .font(.system(size: 40))
                    
                    Spacer ()
                    Button(action: {
                        self.image = CanvasView.snapshot()
                        save(image: self.image!)
                        self.isShowingNextStep = true
                        
                    }, label: {
                        Text(viewModel.finishButtonLabel)
                        
                    }).buttonStyle(.borderedProminent)
                    
                }.padding(.vertical, UIScreen.main.bounds.height*0.05)
                
            }.navigationBarHidden(true)
                .fullScreenCover(isPresented: $isShowingNextStep) {
                    Write(image: self.$image)
                    
                }
        }
    }
    
    func save(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
}

struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasView(viewModel: CanvasViewModel())
    }
}
