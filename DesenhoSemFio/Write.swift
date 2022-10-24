//
//  Write.swift
//  DesenhoSemFio
//
//  Created by Marcelo Diefenbach on 17/10/22.
//

import SwiftUI

struct Write: View {
    
    @Binding var image: UIImage?
    
    var body: some View {
        VStack {
            Image(uiImage: image ?? UIImage(systemName: "trash")!)
            Spacer()
        }
    }
}

struct Write_Previews: PreviewProvider {
    static var previews: some View {
        Write(image: .constant(UIImage(systemName: "plus")))
    }
}
