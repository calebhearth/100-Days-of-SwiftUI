// https://www.hackingwithswift.com/100/swiftui/19

import SwiftUI

protocol Dimensional: Identifiable, CaseIterable, RawRepresentable<String> {
  var dimension: Dimension { get }
}

extension Dimensional {
  var id: RawValue { rawValue }
}

struct ContentView: View {
  @State private var fromDimensionName: String = TemperatureUnit.celsius.rawValue
  @State private var toDimensionName: String = TemperatureUnit.fahrenheit.rawValue
  @State private var fromAmount: Double = 0

  var fromDimension: (any Dimensional)? {
    dimensionFrom(name: fromDimensionName)
  }

  var toDimension: (any Dimensional)? {
    dimensionFrom(name: toDimensionName)
  }

  var fromMeasurement: Measurement<Dimension>? {
    guard let fromDimension else { return nil }
    return  Measurement(value: fromAmount, unit: fromDimension.dimension)
  }

  var convertedMeasurement: Measurement<Dimension>? {
    guard let fromMeasurement, let toDimension else { return nil }
    return fromMeasurement.converted(to: toDimension.dimension)
  }

  private func dimensionFrom(name dimensionName: String) -> (any Dimensional)? {
    TemperatureUnit(rawValue: dimensionName) ??
    MassUnit(rawValue: dimensionName) ??
    TimeUnit(rawValue: dimensionName) ??
    VolumeUnit(rawValue: dimensionName) ??
    LengthUnit(rawValue: dimensionName)
  }

  var toDimensions: [any Dimensional] {
    if let unit = TemperatureUnit(rawValue: fromDimensionName) {
      TemperatureUnit.allCases.filter { $0 != unit }
    } else if let unit = MassUnit(rawValue: fromDimensionName) {
      MassUnit.allCases.filter { $0 != unit }
    } else if let unit = TimeUnit(rawValue: fromDimensionName) {
      TimeUnit.allCases.filter { $0 != unit }
    } else if let unit = VolumeUnit(rawValue: fromDimensionName) {
      VolumeUnit.allCases.filter { $0 != unit }
    } else if let unit = LengthUnit(rawValue: fromDimensionName) {
      LengthUnit.allCases.filter { $0 != unit }
    } else {
      []
    }
  }

  enum TemperatureUnit: String, Dimensional {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvins = "Kelvins"

    var dimension: Dimension {
      switch self {
      case .celsius: UnitTemperature.celsius
      case .fahrenheit: UnitTemperature.fahrenheit
      case .kelvins: UnitTemperature.kelvin
      }
    }
  }

  enum MassUnit: String, Dimensional {
    case kilograms = "Kilograms"
    case pounds = "Pounds"
    case stone = "Stone"

    var dimension: Dimension {
      switch self {
      case .kilograms: UnitMass.kilograms
      case .pounds: UnitMass.pounds
      case .stone: UnitMass.stones
      }
    }
  }

  enum TimeUnit: String, Dimensional {
    case seconds = "Seconds"
    case minutes = "Minutes"
    case hours = "Hours"

    var dimension: Dimension {
      switch self {
      case .seconds: UnitDuration.seconds
      case .minutes: UnitDuration.minutes
      case .hours: UnitDuration.hours
      }
    }
  }

  enum VolumeUnit: String, Dimensional {
    case milliliters = "Milliliters"
    case liters = "Liters"
    case cups = "Cups"
    case gallons = "Gallons"

    var dimension: Dimension {
      switch self {
      case .milliliters: UnitVolume.milliliters
      case .liters: UnitVolume.liters
      case .cups: UnitVolume.cups
      case .gallons: UnitVolume.gallons
      }
    }
  }

  enum LengthUnit: String, Dimensional {
    case meters = "Meters"
    case kilometers = "Kilometers"
    case feet = "Feet"
    case yards = "Yards"
    case miles = "Miles"

    var dimension: Dimension {
      switch self {
      case .meters: UnitLength.meters
      case .kilometers: UnitLength.kilometers
      case .feet: UnitLength.feet
      case .yards: UnitLength.yards
      case .miles: UnitLength.miles
      }
    }
  }

  var body: some View {
    NavigationStack {
      VStack {
        if let fromMeasurement, let convertedMeasurement {
          Spacer()
          HStack {
            Text(fromMeasurement.formatted())
            Text("is")
            Text(convertedMeasurement.formatted())
          }
          .font(.title2)
          .foregroundStyle(.white)
          .frame(maxWidth: .infinity)
          .padding()
          .background(LinearGradient(gradient: Gradient(colors: [.blue,  .pink, .yellow]), startPoint: .leading, endPoint: .trailing))

        }
        Form {
          Section {
            Picker("From", selection: $fromDimensionName) {
              Section("Temperature") {
                ForEach(TemperatureUnit.allCases) { unit in
                  Text(unit.rawValue)
                }
              }
              Section("Mass") {
                ForEach(MassUnit.allCases) { unit in
                  Text(unit.rawValue)
                }
              }
              Section("Time") {
                ForEach(TimeUnit.allCases) { unit in
                  Text(unit.rawValue)
                }
              }
              Section("Volume") {
                ForEach(VolumeUnit.allCases) { unit in
                  Text(unit.rawValue)
                }
              }
              Section("Length") {
                ForEach(LengthUnit.allCases) { unit in
                  Text(unit.rawValue)
                }
              }
            }
            .onChange(of: fromDimensionName) {
              if !toDimensions.contains(where: { $0.rawValue == toDimensionName }) {
                toDimensionName = toDimensions.first!.rawValue
              }
            }
            TextField("Input", value: $fromAmount, format: .number)
              .multilineTextAlignment(.trailing)
              .keyboardType(.decimalPad)
          }
          if !toDimensions.isEmpty {
            Section {
              Picker("To", selection: $toDimensionName) {
                ForEach(toDimensions, id: \.id) { unit in
                  Text(unit.rawValue)
                }
              }
            }
          }
        }
      }
      .navigationTitle("Unit Conversions")
    }
  }
}

#Preview {
  ContentView()
}
