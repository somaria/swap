import SwiftUI

struct ContentView: View {
    let sentence: String
    let word: String
    @State private var displayedSentence: String
    @State private var isShowingCorrect = false
    @State private var misspelledWord: String

    init(sentence: String, word: String) {
        self.sentence = sentence
        self.word = word
        let misspelled = ContentView.createMisspelledWord(from: word)
        self._misspelledWord = State(initialValue: misspelled)
        self._displayedSentence = State(initialValue: sentence.replacingOccurrences(of: word, with: misspelled))
    }

    var body: some View {
        VStack {
            highlightedText(isShowingCorrect ? sentence : displayedSentence, word: isShowingCorrect ? word : misspelledWord)
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
    
    static func createMisspelledWord(from word: String) -> String {
        // Create a misspelled version of the word
        var misspelledWord = word
        let indices = getValidSwapIndices(for: misspelledWord)
        misspelledWord.swapAt(indices.0, indices.1)
        return misspelledWord
    }
    
    // Function to find valid indices to swap, ensuring no identical characters are swapped
    static func getValidSwapIndices(for word: String) -> (String.Index, String.Index) {
        var validIndices: [(String.Index, String.Index)] = []
        let chars = Array(word)
        
        for i in 1..<(chars.count - 1) where chars[i] != chars[i + 1] {
            let startIndex = word.index(word.startIndex, offsetBy: i)
            let endIndex = word.index(word.startIndex, offsetBy: i + 1)
            validIndices.append((startIndex, endIndex))
        }
        
        // Randomly select a valid pair of indices
        return validIndices.randomElement() ?? (word.startIndex, word.index(after: word.startIndex))
    }
    
    func highlightedText(_ sentence: String, word: String) -> Text {
        let parts = sentence.components(separatedBy: word)
        var text = Text("")
        
        for (index, part) in parts.enumerated() {
            text = text + Text(part)
            if index < parts.count - 1 {
                text = text + Text(word).underline()
            }
        }
        
        return text
    }
}


extension String {
    mutating func swapAt(_ i: String.Index, _ j: String.Index) {
        let temp = self[i]
        self.replaceSubrange(i...i, with: [self[j]])
        self.replaceSubrange(j...j, with: [temp])
    }
}
