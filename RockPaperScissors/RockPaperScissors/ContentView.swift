import SwiftUI

enum Move: String, CaseIterable {
  case rock
  case paper
  case scissors

  func losesTo(_ move: Move) -> Bool {
    self.losesTo == move
  }

  var losesTo: Move {
    switch self {
    case .rock: .paper
    case .paper: .scissors
    case .scissors: .rock
    }
  }

  func beats(_ move: Move) -> Bool {
    self.beats == move
  }

  var beats: Move {
    switch self {
    case .rock: .scissors
    case .paper: .rock
    case .scissors: .paper
    }
  }

  var emoji: String {
    switch self {
    case .rock: "🪨"
    case .paper: "📄"
    case .scissors: "✂️"
    }
  }

  static func random() -> Move {
    allCases.randomElement()!
  }
}

struct ContentView: View {
  @State var score = 0
  @State var round = 0
  let totalRounds = 10

  var body: some View {
    NavigationStack {
      ZStack {
        VStack {
          if round < totalRounds {
            PlayRound(score: $score, round: $round)
          } else {
            FinalScore(score: $score, round: $round)
          }
        }
        .navigationTitle("Rock, Paper, Scissors")
        .padding()
      }
      .background(Color.brown.gradient)
    }
  }
}

#Preview {
  ContentView()
}

struct PlayRound: View {
  @Binding var score: Int
  @Binding var round: Int
  @State var currentMove: Move = Move.random()
  @State var playerShouldWin: Bool = Bool.random()

  var body: some View {
    Text("Score: \(score)")
    Text("My Move: \(currentMove.emoji)")
    HStack(spacing: 0) {
      Text("Select the move to ")
      if playerShouldWin {
        Text("win").foregroundStyle(.blue)
      } else {
        Text("lose").foregroundStyle(.orange)
      }
    }
    Spacer()
    HStack {
      ForEach(Move.allCases, id: \.rawValue) { move in
        Button {
          withAnimation {
            if playerShouldWin ? move.beats(currentMove) : move.losesTo(currentMove) {
              score += 1
            }
            nextRound()
          }
        } label: {
          Text(move.emoji)
            .font(.largeTitle)
        }
        .padding(10)
        .background(Color.indigo.gradient, in: RoundedRectangle(cornerRadius: 10))

        if move != .scissors {
          Spacer()
        }
      }
    }
    .frame(maxWidth: .infinity)
    .padding()
  }

  func nextRound() {
    currentMove = Move.random()
    playerShouldWin = Bool.random()
    round += 1
  }
}

struct FinalScore: View {
  @Binding var score: Int
  @Binding var round: Int

  var body: some View {
    Group {
      Text("Final Score: \(score)")
      Spacer()
      Button("New Game") {
        withAnimation {
          round = 0
          score = 0
        }
      }
      .frame(maxWidth: .infinity)
      .padding(10)
      .background(Color.indigo.gradient, in: RoundedRectangle(cornerRadius: 10))
      .foregroundStyle(.white)
      Spacer()
    }
  }
}
