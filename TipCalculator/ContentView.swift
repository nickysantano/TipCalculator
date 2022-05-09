//
//  ContentView.swift
//  TipCalculator
//
//  Created by Nicky Santano on 25/04/22.
//

import SwiftUI
import CTScanText

struct ContentView: View {
    @State private var check = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    @FocusState private var isInputActive: Bool
    
    private let tipPercentages = [10, 15, 20, 25, 0]
    
    let currencyformat: NumberFormatter = {
                let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.zeroSymbol = ""
            formatter.currencySymbol = ""
                return formatter
            }()
    
    private var subTotal: Double{
        Double(check) ?? 0
    }
    
    private var subTotalPerPerson: Double{
        let peopleCount = Double(numberOfPeople)
        let order = Double(check) ?? 0
        
        return order / peopleCount
    }
    
    private var tipValue: Double{
        let tipSelection = Double(tipPercentages[tipPercentage])
        let order = Double(check) ?? 0
        
        return order / 100 * tipSelection
    }
    
    private var tipValuePerPerson: Double{
        tipValue / Double(numberOfPeople)
    }
    
    private var totalWithTip: Double{
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(check) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    private var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople)
        let amountPerPerson = totalWithTip / peopleCount
        
        return amountPerPerson
    }
    
    init(){
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(.cyan)
    }
    
    var body: some View {
        
        GeometryReader{ geo in
            ZStack {
                Image("wallpaper")
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                
                VStack(alignment: .center, spacing: 20){
                    Spacer()
                    CardView(cardLabelText: "Per Orang", total: Int(totalPerPerson), subtotal: Int(subTotalPerPerson), tip: Int(tipValuePerPerson))
                        .frame(width: geo.size.width-24, height: 100)
                    
                    
                    CardView(cardLabelText: "Total", total: Int(totalWithTip), subtotal: Int(subTotal), tip: Int(tipValue))
                        .frame(width: geo.size.width-24, height: 100)
                    
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(0..<tipPercentages.count){
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    TitleView(title: "Jumlah Bill")
                    
                    HStack{
                        Text("Rp")
                            .foregroundColor(.black)
                            .font(.system(size: 60, weight: .black, design: .rounded))
                        
                        TextField("Amount", text: $check).onChange(of: check, perform: { newValue in
                            var new = newValue
                            
                            new = new.replacingOccurrences(of: ".", with: "")
                            new = new.replacingOccurrences(of: ",", with: "")
                            new = new.replacingOccurrences(of: "Rp", with: "")
                            new = new.replacingOccurrences(of: " ", with: "")
                            
                            new = new.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789.").inverted)
                            
                            check = new
                            
                            print(check)
                        })
                            .foregroundColor(.black)
                            .font(.system(size: 60, weight: .black, design: .rounded))
                            .textContentType(.telephoneNumber)
                            .keyboardType(.decimalPad)
                            .focused($isInputActive)
                            .frame(height:60)
                        
                            .toolbar{
                                ToolbarItemGroup(placement: .keyboard){
                                    
                                    
                                    Spacer()
                                    
                                    Button("Done"){
                                        isInputActive = false
                                    }
                                }
                            }
                    }
                    TitleView(title: "Dibagi")
                    GuestCountView(guestCount: $numberOfPeople)
                    Spacer()
                    Spacer()
                    
                }
                .padding()
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TitleView: View {
    var title: String
    
    var body: some View {
        HStack{
            Text(title)
                .foregroundColor(.cyan)
                .fontWeight(.black)
            Spacer()
        }
    }
}
