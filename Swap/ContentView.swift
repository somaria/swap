import SwiftUI

struct ContentView: View {
    let sentence = "This is a school."
    let word = "school"
    @State private var displayedSentence: String
    @State private var isShowingCorrect = false

    init() {
        // Swap two characters in the word to create a misspelled version
        var misspelledWord = word
        let randomIndex = Int.random(in: 0..<(misspelledWord.count - 1))
        let startIndex = misspelledWord.index(misspelledWord.startIndex, offsetBy: randomIndex)
        let endIndex = misspelledWord.index(misspelledWord.startIndex, offsetBy: randomIndex + 1)
        misspelledWord.swapAt(startIndex, endIndex)

        // Replace the word in the sentence with the misspelled word
        _displayedSentence = State(initialValue: sentence.replacingOccurrences(of: word, with: misspelledWord))
    }

    var body: some View {
        VStack {
            Text(isShowingCorrect ? sentence : displayedSentence)
                .padding()
                .font(.largeTitle)
                .onTapGesture {
                    isShowingCorrect.toggle()
                }

            if isShowingCorrect {
                Text("Tap to see the incorrect version.")
                    .padding()
            } else {
                Text("Tap to see the correct version.")
                    .padding()
            }
        }
    }
}


extension String {
    mutating func swapAt(_ i: String.Index, _ j: String.Index) {
        let temp = self[i]
        self.replaceSubrange(i...i, with: [self[j]])
        self.replaceSubrange(j...j, with: [temp])
    }
}

