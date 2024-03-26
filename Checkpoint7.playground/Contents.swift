class Animal {
  let legs: Int

  init(legs: Int) {
    self.legs = legs
  }
}

class Dog: Animal {
  func speak() {
    print("Bark")
  }
}

class Corgi: Dog {
  override func speak() {
    print("Yip")
  }
}

class Poodle: Dog {
  override func speak() {
    print("Yap Yap!")
  }
}

class Cat: Animal {
  let isTame: Bool

  init(legs: Int, isTame: Bool) {
    self.isTame = isTame
    super.init(legs: legs)
  }

  func speak() {
    print("Meow")
  }
}

class Persian: Cat {
  init() {
    super.init(legs: 4, isTame: true)
  }

  override func speak() {
    print("Feed me from a can")
  }
}

class Lion: Cat {
  init() {
    super.init(legs: 4, isTame: false)
  }

  override func speak() {
    print("Feed me yourself")
  }
}

let human = Animal(legs: 2)
Dog(legs: 4).speak()
Corgi(legs: 4).speak()
Poodle(legs: 4).speak()
Cat(legs: 3, isTame: true).speak()
Persian().speak()
Lion().speak()
