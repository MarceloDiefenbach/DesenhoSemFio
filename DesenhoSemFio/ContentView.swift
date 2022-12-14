//
//  ContentView.swift
//  DesenhoSemFio
//
//  Created by Marcelo Diefenbach on 17/10/22.
//

import SwiftUI

struct Line {
    var points = [CGPoint]()
    var color: Color = .black
    var lineWidth: Double = 5.0
}

struct ContentView: View {
    
    @State private var currentLine = Line()
    @State private var lines: [Line] = []
    @State private var image: UIImage?
    @State private var isShowingNextStep: Bool = false
    
    var canvas: some View {
        Canvas { contex, size in
            
            for line in lines {
                var path = Path()
                path.addLines(line.points)
                contex.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
            }
            
        }.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onChanged({value in
                let newPoint = value.location
                currentLine.points.append(newPoint)
                self.lines.append(currentLine)
            })
                .onEnded({ value in
                    self.currentLine = Line(points: [])
                })
        ).frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                canvas
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.lines.removeAll()
                        }, label: {
                            Image(systemName: "xmark.circle.fill").foregroundColor(.black)
                                .font(.system(size: 30))
                        })
                    }
                    Spacer()
                }.padding(.all, 20)
                VStack {
                    Text("Desenhe:")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .font(.system(size: 16))
                    
                    Text("Garfo")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .font(.system(size: 40))
                    
                    Spacer ()
                    Button(action: {
                        self.image = canvas.snapshot()
                        save(image: self.image!)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            self.isShowingNextStep = true
                        })
                    }, label: {
                        Text("Pronto!")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
