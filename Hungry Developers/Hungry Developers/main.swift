//
//  Hungry Developers.swift
//
//
//  Created by Samantha Gatt on 9/5/18.
//

import Cocoa

// MARK: - Developer Object

class Developer {
    
    init(name: String, leftSpoon: Spoon, rightSpoon: Spoon) {
        self.name = name
        self.leftSpoon = leftSpoon
        self.rightSpoon = rightSpoon
    }
    
    // MARK: - Properties
    
    let name: String
    var leftSpoon: Spoon
    var rightSpoon: Spoon
    
    
    // MARK: - Methods
    
    func think() {
        DispatchQueue.concurrentPerform(iterations: 2) { int in
            if int == 0 {
                leftSpoon.pickUp()
                print("\(name) picked up left spoon")
            } else {
                rightSpoon.pickUp()
                print("\(name) picked up right spoon")
            }
        }
    }
    
    func eat() {
        usleep((arc4random_uniform(8) + 2) * 10000)
        leftSpoon.putDown()
        rightSpoon.putDown()
        print("\(name) done eating")
    }
    
    func run() {
        while true {
            think()
            eat()
        }
    }
}


// MARK: - Spoon Object

class Spoon {
    
    // MARK: - Properties
    
    private var isPickedUp = false
    private let lock = NSLock()
    
    
    // MARK: - Methods
    
func pickUp() {
    while isPickedUp { continue }
    
    lock.lock()
    print("before changing isPickedUp")
    isPickedUp = true
    lock.unlock()
}
    
    func putDown() {
        lock.lock()
        isPickedUp = false
        lock.unlock()
    }
}


// MARK: - Testing

var spoon1 = Spoon()
var spoon2 = Spoon()
var spoon3 = Spoon()
var spoon4 = Spoon()
var spoon5 = Spoon()

var developer1 = Developer(name: "Developer1", leftSpoon: spoon1, rightSpoon: spoon2)
var developer2 = Developer(name: "Developer2", leftSpoon: spoon2, rightSpoon: spoon3)
var developer3 = Developer(name: "Developer3", leftSpoon: spoon3, rightSpoon: spoon4)
var developer4 = Developer(name: "Developer4", leftSpoon: spoon4, rightSpoon: spoon5)
var developer5 = Developer(name: "Developer5", leftSpoon: spoon5, rightSpoon: spoon1)

let developers = [developer1, developer2, developer3, developer4, developer5]

DispatchQueue.concurrentPerform(iterations: 5) { i in
    developers[i].run()
}

CFRunLoopRun()
