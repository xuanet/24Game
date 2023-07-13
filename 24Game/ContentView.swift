//
//  ContentView.swift
//  24Game
//
//  Created by Kevin Xu on 6/29/23.
//

import SwiftUI
import MathExpression

struct ContentView: View {
    
    
    let operationFontSize = 50.0
    let operationCellSize = 80.0
    // keeps track of the current cards
    @State var currentCards = ["1", "2", "3", "4"]
    @State var currentCardsImages = ["card1", "card2", "card3", "card4"]
    @State var currentCardsImagesSavedCopy = ["card1", "card2", "card3", "card4"]
    
    // constructs the string expression, is an array of characters
    @State var expression = [String]()
    @State var evaluatedAnswer: Double = 0
    @State var usedIdx = IntStack()
    
    @State var solvedCount = 0
    @State var skippedCount = 0
    @State var lastInputWasOperator = true
    
    let operators: Set = ["+", "-", "*", "/", "(", ")"]
    let InvalidResult = -101.0
    let tolerance = 0.01
    let target = 24.0
    
    
    var body: some View {
        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack(spacing: 30){
                
                Spacer()
                
                // SCORES
                
                Group {
                    HStack(spacing: 50) {
                        VStack {
                            Text("Solved")
                                .foregroundColor(.white)
                                .padding()
                            Text(String(solvedCount))
                                .foregroundColor(.white)
                                .padding()
                        }
                        VStack {
                            Text("Skipped")
                                .foregroundColor(.white)
                                .padding()
                            Text(String(skippedCount))
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                }
                
                // EXPRESSION AND EVALUATION
                
                Group {
                    Text(expression.joined())
                        .foregroundColor(.white)
                    Text(String(evaluatedAnswer))
                        .foregroundColor(.white)
                }
                
                // IMAGES OF CARDS
                
                Group {
                    HStack(spacing: 50) {
                        Button {
                            if !usedIdx.contains(0) && (expression.count == 0 || operators.contains(expression[expression.count-1])) {
                                expression.append((currentCards[0]))
                                currentCardsImages[0] = "back"
                                usedIdx.push(0)
                            }
                        } label: {
                            Image(currentCardsImages[0])
                        }
                        Button {
                            if !usedIdx.contains(1) && (expression.count == 0 || operators.contains(expression[expression.count-1])) {
                                expression.append((currentCards[1]))
                                currentCardsImages[1] = "back"
                                usedIdx.push(1)
                            }
                        } label: {
                            Image(currentCardsImages[1])
                        }

                    }
                    HStack(spacing: 50) {
                        Button {
                            if !usedIdx.contains(2) && (expression.count == 0 || operators.contains(expression[expression.count-1])) {
                                expression.append((currentCards[2]))
                                currentCardsImages[2] = "back"
                                usedIdx.push(2)
                            }
                        } label: {
                            Image(currentCardsImages[2])
                        }
                        Button {
                            if !usedIdx.contains(3) && (expression.count == 0 || operators.contains(expression[expression.count-1])) {
                                expression.append((currentCards[3]))
                                currentCardsImages[3] = "back"
                                usedIdx.push(3)
                            }
                        } label: {
                            Image(currentCardsImages[3])
                        }
                    }
                }
                
                // OPERATORS
                
                Group {
                    HStack {
                        Button {
                            expression.append("(")
                        } label: {
                            Text("(")
                                .font(.system(size: operationFontSize))
                                .padding()
                                .fixedSize()
                                .frame(width: operationCellSize, height: operationCellSize)
                                .foregroundColor(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 10,
                                        style: .continuous
                                    )
                                    .fill(Color.orange)
                                )
                        }
                        
                        Button {
                            expression.append(")")
                        } label: {
                            Text(")")
                                .font(.system(size: operationFontSize))
                                .padding()
                                .fixedSize()
                                .frame(width: operationCellSize, height: operationCellSize)
                                .foregroundColor(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 10,
                                        style: .continuous
                                    )
                                    .fill(Color.orange)
                                )
                        }
                    }
                    HStack {
                        Button {
                            expression.append("+")
                        } label: {
                            Text("+")
                                .font(.system(size: operationFontSize))
                                .padding()
                                .fixedSize()
                                .frame(width: operationCellSize, height: operationCellSize)
                                .foregroundColor(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 10,
                                        style: .continuous
                                    )
                                    .fill(Color.orange)
                                )
                        }
                        
                        Button {
                            expression.append("-")
                        } label: {
                            Text("-")
                                .font(.system(size: operationFontSize))
                                .padding()
                                .fixedSize()
                                .frame(width: operationCellSize, height: operationCellSize)
                                .foregroundColor(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 10,
                                        style: .continuous
                                    )
                                    .fill(Color.orange)
                                )
                        }
                        
                        Button {
                            expression.append("*")
                        } label: {
                            Text("*")
                                .font(.system(size: operationFontSize))
                                .padding()
                                .fixedSize()
                                .frame(width: operationCellSize, height: operationCellSize)
                                .foregroundColor(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 10,
                                        style: .continuous
                                    )
                                    .fill(Color.orange)
                                )
                        }
                        
                        Button {
                            expression.append("/")
                        } label: {
                            Text("/")
                                .font(.system(size: operationFontSize))
                                .padding()
                                .fixedSize()
                                .frame(width: operationCellSize, height: operationCellSize)
                                .foregroundColor(.black)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 10,
                                        style: .continuous
                                    )
                                    .fill(Color.orange)
                                )
                        }
                    }
                }
                
                // BUTTONS
                
                Group {
                    Button {
                        if expression.count > 0 {
                            if !operators.contains(expression[expression.count-1]) {
                                // if the item to be deleted is not an operator
                                print(expression[expression.count-1])
                                let justDeleted = usedIdx.pop()
                                currentCardsImages[justDeleted] = currentCardsImagesSavedCopy[justDeleted]
                            }
                            expression.removeLast()
                            print(usedIdx)
                        }
                    } label: {
                        Text("Delete")
                    }

                    Button {
                        let temp = evaluate(expression.joined())
                        if temp != InvalidResult {
                            evaluatedAnswer = temp
                            print(evaluatedAnswer)
                            if checkResult(evaluatedAnswer) {
                                resetForNewGame(1)
                            }
                        }
                    } label: {
                        Text("Evaluate")
                    }
                    
                    
                    Button {
                        resetForNewGame(0)
                    } label: {
                        Text("New")
                    }
                }
                Spacer()
            }
        }
    }
    
    func evaluate(_ input: String) -> Double {
        do {
            let expression = try MathExpression(input)
            return expression.evaluate()
        } catch {
            // invalid expression
            return InvalidResult
        }
    }
    
    func checkResult(_ answer: Double) -> Bool {
        if usedIdx.count() != 4 {
            return false
        }
        let result = abs(target - answer) < tolerance ? true : false
        return result
    }
    
    func newGame() {
        let name = "card"
        for i in 0...3 {
            let temp = Int.random(in: 1...13)
            currentCards[i] = String(temp)
            currentCardsImages[i] = name+String(temp)
            currentCardsImagesSavedCopy[i] = name+String(temp)
        }
    }
    
    func resetForNewGame(_ result: Int) {
        if result == 1 {
            // got 24
            solvedCount += 1
        }
        else {
            skippedCount += 1
        }
        newGame()
        expression.removeAll()
        usedIdx.clear()
        evaluatedAnswer = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
