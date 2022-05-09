//
//  CardView.swift
//  TipCalculator
//
//  Created by Nicky Santano on 25/04/22.
//

import SwiftUI

struct CardView: View {
    
    var cardLabelText = ""
    var total = 69000
    var subtotal = 42000
    var tip = 6500
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0){
            
            Text(cardLabelText)
                .foregroundColor(.cyan)
                .fontWeight(.black)
            
            ZStack {
                Rectangle()
                    .foregroundColor(.gray)
                    .cornerRadius(15)
                    .opacity(0.75)
                
                HStack{
                    Spacer()
                    Text("Rp\(total)")
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .black, design: .monospaced))
                        .fontWeight(.black)
                    
                    Spacer()
                    
                    Rectangle()
                        .foregroundColor(Color(red: 128/255, green: 128/255, blue: 128/255))
                        .frame(width: 1, height: 70)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 10){
                        VStack(alignment: .leading){
                            Text("SUBTOTAL")
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.light)
                            Text("Rp\(subtotal)")
                                .font(.system(.body, design: .monospaced))
                                .fontWeight(.black)
                        }
                        
                        VStack(alignment: .leading){
                            Text("TIP")
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.light)
                            Text("Rp\(tip)")
                                .font(.system(.body, design: .monospaced))
                                .fontWeight(.black)
                        }
                    }
                    .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(5)
            }
            
        }
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(cardLabelText: "PER ORANG")
            .frame(width: 300, height: 150)
    }
}
