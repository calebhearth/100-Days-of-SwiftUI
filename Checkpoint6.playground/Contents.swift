// https://www.hackingwithswift.com/quick-start/beginners/checkpoint-6

import Foundation

struct Car {
  let model: String
  let seatCount: Int
  var currentGear: Gear

  enum Gear: Int, CustomStringConvertible {
    case reverse = -1
    case park = 0
    case first = 1
    case second = 2
    case third = 3
    case fourth = 4

    var description: String {
      switch self {
      case .reverse:
        return "reverse"
      case .park:
        return "park"
      case .first, .second, .third, .fourth:
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return "\(formatter.string(from: rawValue as NSNumber)!) gear"
      }
    }
  }

  mutating func shiftGear(to gear: Gear) {
    print("Shifting to \(gear)")
    currentGear = gear
  }
}

var car = Car(model: "Focus", seatCount: 4, currentGear: .park)
car.shiftGear(to: .first)
car.shiftGear(to: .second)
car.shiftGear(to: .park)
