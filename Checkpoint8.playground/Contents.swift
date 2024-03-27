protocol Building {
  var rooms: Int { get }
  var cost: Int { get set }
  var estateAgent: String { get set }
  func printSalesSummary()
}

struct House: Building {
  let rooms: Int
  var cost: Int
  var estateAgent: String
  
  func printSalesSummary() {
    print("Never sold")
  }
}

struct Office: Building {
  let rooms: Int
  var cost: Int
  var estateAgent: String

  func printSalesSummary() {
    print("Sold 2 years ago for $100,000")
  }
}
