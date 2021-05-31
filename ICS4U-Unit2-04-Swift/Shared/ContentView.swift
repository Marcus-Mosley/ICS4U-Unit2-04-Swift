//
// ContentView.swift
// ICS4U-Unit2-04-Swift
//
// Created by Marcus A. Mosley on 2021-05-31
// Copyright (C) 2021 Marcus A. Mosley. All rights reserved.
//

import SwiftUI

struct ActiveAlert: Identifiable {
    enum Choice {
        case type, index
    }

    var id: Choice
}

struct ContentView: View {
    @State private var showAlert = false
    @State private var activeAlert: ActiveAlert?
    @State private var astack: MrCoxallStack = MrCoxallStack()
    @State private var anumber: String = ""
    @State private var anumber2: String = ""
    @State private var text: String = ""
    @State private var tmp: Int = 0

    var body: some View {
        VStack {
            TextField("What would you like to do (1: Push, 2: Pop, 3: Peek, 4: Clear)? ", text: $anumber)
                .padding()
            TextField("Push: Please Enter a Number: ", text: $anumber2)
                .padding()
            Button("Enter", action: {
                if Int(anumber) != nil {
                    if Int(anumber) == 1 {
                        if Int(anumber2) != nil {
                            astack.push(Int(anumber2)!)
                            text = "\nPushed \(anumber2) to Stack"
                            text += "\nStack: \(astack.showStack())"
                        } else {
                            activeAlert = ActiveAlert(id: .type)
                        }
                    } else if Int(anumber) == 2 {
                        if !astack.empty() {
                            tmp = astack.pop()
                            text += "\nPopped \(String(tmp)) from Stack"
                            text += "\nStack: \(astack.showStack())"
                        } else {
                            activeAlert = ActiveAlert(id: .index)
                        }
                    } else if Int(anumber) == 3 {
                        if !astack.empty() {
                            tmp = astack.peek()
                            text += "\n\(String(tmp)) is at the top of the Stack"
                        } else {
                            activeAlert = ActiveAlert(id: .index)
                        }
                    } else if Int(anumber) == 4 {
                        astack.clear()
                        text += "\nThe Stack has been successfully cleared"
                        text += "\nStack: \(astack.showStack())"
                    } else {
                        activeAlert = ActiveAlert(id: .type)
                    }
                } else {
                    activeAlert = ActiveAlert(id: .type)
                }
                anumber = ""
                anumber2 = ""
            })
            .padding()
            .alert(item: $activeAlert) { alert in
                switch alert.id {
                case .type:
                    return Alert(title: Text("Important Message"), message: Text("Not Valid Input"),
                        dismissButton: .default(Text("Got It!")))
                case .index:
                    return Alert(title: Text("Important Message"), message: Text("The Stack is Empty"),
                        dismissButton: .default(Text("Got It!")))
                }
            }
            Text("\(text)")
        }
    }
}

class MrCoxallStack {
    var stackAsArray = [Int]()

    // Pushes an integer to the array
    func push(_ pushNumber: Int) {
        stackAsArray.append(pushNumber)
    }

    // Pops an integer from the array
    func pop() -> Int {
        let tmp: Int = stackAsArray[stackAsArray.count - 1]
        stackAsArray.removeLast()
        return tmp
    }

    // Returns the top integer from the array
    func peek() -> Int {
        return stackAsArray[stackAsArray.count - 1]
    }

    // Clears all integers from the array
    func clear() {
        stackAsArray.removeAll()
    }

    // Determines if the array is empty
    func empty() -> Bool {
        if stackAsArray.count == 0 {
            return true
        } else {
            return false
        }
    }

    // Outputs the array
    func showStack() -> String {
        var text: String = ""

        for count in 0..<stackAsArray.count {
            text += "\(String(stackAsArray[count])), "
        }
        return text
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
