//
//  CanvasViewModel.swift
//  DesenhoSemFio
//
//  Created by Marcelo Diefenbach on 17/10/22.
//

import SwiftUI

class CanvasViewModel: ObservableObject {
    
    @Published var currentLine = Line()
    @Published var lines: [Line] = []
    @Published var image: UIImage?
    
    //MARK: - Content
    @Published var drawThis: String = "Desenhe:"
    @Published var thingToDraw: String = "Garfo"
    @Published var finishButtonLabel: String = "Pronto!"
    
    //MARK: - Functions
    
    func addLine(value: DragGesture.Value) {
        let newPoint = value.location
        currentLine.points.append(newPoint)
        lines.append(currentLine)
    }
    
    func cleanCanvas() {
        lines.removeAll()
    }
    
    func cleanLineToRestart() {
        currentLine = Line(points: [])
    }
    
    func goToNextStep() {
        
    }
}
