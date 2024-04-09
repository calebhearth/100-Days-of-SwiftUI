import SwiftUI

struct MainTitle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.largeTitle)
      .fontWeight(.bold)
      .foregroundStyle(.white)
  }
}

extension View {
  func mainTitle() -> some View {
    modifier(MainTitle())
  }
}

struct ContentView: View {
  @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
  @State private var correctAnswer = Int.random(in: 0...2)
  @State private var showingScore = false
  @State private var scoreTitle = ""
  @State private var score = 0
  @State private var roundNumber = 0
  @State private var roundOver = false
  let roundsInGame = 8

  var body: some View {
    ZStack {
      RadialGradient(stops: [
        .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
        .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
      ], center: .top, startRadius: 200, endRadius: 700)
      .ignoresSafeArea()

      VStack {
        Spacer()

        Text("Guess the Flag")
          .mainTitle()


        VStack(spacing: 15) {
          VStack {
            Text("Tap the flag of")
              .font(.subheadline)
              .fontWeight(.heavy)
              .foregroundStyle(.secondary)

            Text(countries[correctAnswer])
              .font(.largeTitle)
              .fontWeight(.semibold)
          }

          ForEach(0..<3) { number in
            Button {
              flagTapped(number)
            } label: {
              FlagImage(countries[number])
            }
          }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.regularMaterial)
        .clipShape(.rect(cornerRadius: 20))

        Spacer()
        Spacer()

        Text("Score: \(score)")
          .foregroundStyle(.white)
          .font(.title.bold())

        Spacer()
      }
      .padding()
    }
    .alert(scoreTitle, isPresented: $showingScore) {
      Button("Continue", action: askQuestion)
    } message: {
      Text("Your score is \(score)")
    }
    .alert("Great guessing!", isPresented: $roundOver) {
      Button("Start again") {
        roundNumber = 0
        score = 0
        roundOver = false
        askQuestion()
      }
    } message: {
      Text("Your final score is \(score)/\(roundsInGame)")
    }
  }

  func flagTapped(_ number: Int) {
    if number == correctAnswer {
      scoreTitle = "Correct"
      score += 1
    } else {
      scoreTitle = "Wrong! That's the flag of \(countries[number])"
    }

    roundNumber += 1
    if roundNumber >= roundsInGame {
      roundOver = true
    } else {
      showingScore = true
    }
  }

  func askQuestion() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
  }
}

#Preview {
  ContentView()
}
