import SwiftUI

struct ContentView: View {
  @State private var checkAmount: Decimal = 0
  @State private var numberOfPeople = 2
  @State private var tipPercentage: Decimal = 0.20
  @FocusState private var amountIsFocused: Bool
  let tipPercentages: [Decimal] = [0.10, 0.15, 0.20, 0.25]
  var tipAmount: Decimal {
    checkAmount * tipPercentage
  }
  var currencyCode = Locale.current.currency?.identifier ?? "USD"
  var checkTotal: Decimal {
    checkAmount + tipAmount
  }
  var totalPerPerson: Decimal {
    checkTotal / Decimal(numberOfPeople)
  }

  var body: some View {
    NavigationStack {
      Form {
        Section {
          LabeledContent {
            TextField("Check Amount", value: $checkAmount, format: .currency(code: currencyCode))
              .multilineTextAlignment(.trailing)
              .focused($amountIsFocused)
              .keyboardType(.decimalPad)
          } label: {
            Text("Check Amount")
          }
          Picker("Number of People", selection: $numberOfPeople) {
            ForEach(2..<100, id: \.self) {
              Text("\($0) people")
            }
          }
        }
        Section("How much do you want to tip?") {
          Picker("Tip Percentage", selection: $tipPercentage) {
            ForEach(tipPercentages, id: \.self) {
              Text($0, format: .percent)
            }
          }
          .pickerStyle(.segmented)
        }
        Section {
          Grid(alignment: .trailing) {
            GridRow {
              Text("Total tip: ")
              Text(tipAmount, format: .currency(code: currencyCode))
            }
            GridRow {
              Text("Total with Tip: ")
              Text(checkTotal, format: .currency(code: currencyCode))
            }
            GridRow {
              Text("Total per person: ")
              Text(totalPerPerson, format: .currency(code: currencyCode))
            }
          }
          .frame(maxWidth: .infinity)
        }
      }
      .onTapGesture {
        amountIsFocused = false
      }
      .navigationTitle("WeSplit")
      .toolbar {
        if amountIsFocused {
          Button("Done") {
            amountIsFocused = false
          }
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
