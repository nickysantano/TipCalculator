//
//  GuestCountView.swift
//  TipCalculator
//
//  Created by Nicky Santano on 25/04/22.
//

import SwiftUI

struct GuestCountView: View {
    @Binding var guestCount: Int
    
    
    var body: some View {
        
        HStack(spacing: 20){
            Button{
                if guestCount > 1{
                    guestCount -= 1
                }
            }label: {
                Image(systemName: "minus.circle")
                    .foregroundColor(.cyan)
                    .font(.system(.title, design: .rounded))
            }
            
            Text("\(guestCount)")
                .foregroundColor(.primary)
                .font(.system(size: 40, weight: .black, design: .monospaced))
            
            Button{
                guestCount += 1
            }label: {
                Image(systemName: "plus.circle")
                    .foregroundColor(.cyan)
                    .font(.system(.title, design: .rounded))
            }
        }
        
    }
}

struct GuestCountView_Previews: PreviewProvider {
    static var previews: some View {
        GuestCountView(guestCount: .constant(1))
            
    }
}
