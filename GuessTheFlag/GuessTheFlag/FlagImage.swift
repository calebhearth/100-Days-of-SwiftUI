import SwiftUI

struct FlagImage: View {
  let name: String

  init(_ name: String) {
    self.name = name
  }

  var body: some View {
    Image(name)
      .clipShape(.capsule)
      .shadow(radius: 5)
  }
}
