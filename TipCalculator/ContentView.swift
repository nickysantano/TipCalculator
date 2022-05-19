//
//  ContentView.swift
//  TipCalculator
//
//  Created by Nicky Santano on 25/04/22.
//

import SwiftUI
import CTScanText

struct ContentView: View {
    @AppStorage("isDarkMode") private var isDark = false
    
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
        
        NavigationView {
            GeometryReader{ geo in
                ZStack {
                    Color("ColorBg")
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(alignment: .center, spacing: 20){
                        Spacer()
                        CardView(cardLabelText: "Per Orang", total: Int(totalPerPerson), subtotal: Int(subTotalPerPerson), tip: Int(tipValuePerPerson))
                            .frame(width: geo.size.width-24, height: 100)
                        
                            .padding(15)
                        
                        CardView(cardLabelText: "Total", total: Int(totalWithTip), subtotal: Int(subTotal), tip: Int(tipValue))
                            .frame(width: geo.size.width-24, height: 100)
                        
                            
                            
                        
                        Picker("Tip Percentage", selection: $tipPercentage){
                            ForEach(0..<tipPercentages.count){
                                Text("\(self.tipPercentages[$0])%")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .accessibilityLabel("The percentage of the tip you want to give. To choose what percentage of the total that needs to be paid to be given to the waiter.")
                        
                        TitleView(title: "Jumlah Bill")
                            .accessibilityLabel("Number of bills. To enter the total bill that needs to be paid. In addition to entering manually, you can also use scan text by double-clicking on the text field below and selecting the Scan text button.")
                        
                        HStack{
                            Text("Rp")
                                .foregroundColor(.primary)
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
                                .foregroundColor(.primary)
                                .font(.system(size: 60, weight: .black, design: .rounded))
                                .textContentType(.telephoneNumber)
                                .keyboardType(.decimalPad)
                                .focused($isInputActive)
                                .frame(height:60)
                            
                                .toolbar{
                                    ToolbarItemGroup(placement: .keyboard){
                                        Button{
                                            
                                        }label: {
                                            Image(systemName: "viewfinder")
                                        }
                                        
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
                }.toolbar{
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        Button  (
                            action:{
                                isDark.toggle()
                            },
                            label: {
                                isDark ? Label("Dark", systemImage: "lightbulb.fill") : Label("Dark", systemImage: "lightbulb")
                            }
                        ).accessibilityLabel("Button to turn on dark mode or light mode in this application.")

                    }
                }
                
            }.environment(\.colorScheme, isDark ? .dark : .light)
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
