// https://www.hackingwithswift.com/quick-start/beginners/checkpoint-4

enum SquareRoot: Error {
  case noRoot
  case outOfBounds
}

func getSquareRoot(of square: Int) throws -> Int {
  if !(1...10000).contains(square) {
    throw SquareRoot.outOfBounds
  }
  for potentialRoot in (1...100) {
    if potentialRoot * potentialRoot == square {
      return potentialRoot
    }
  }
  throw SquareRoot.noRoot
}

do {
  do {
    print(try getSquareRoot(of: 7))
  } catch SquareRoot.noRoot {
    print("7 is prime")
  }
  print(try getSquareRoot(of: 100))
  print(try getSquareRoot(of: 10_000))
  do {
    try getSquareRoot(of: -1)
  } catch SquareRoot.outOfBounds {
    print("-1 out of bounds")
  }
  do {
    try getSquareRoot(of: 10_001)
  } catch SquareRoot.outOfBounds {
    print("-1 out of bounds")
  }
} catch let error {
  print(error)
}
