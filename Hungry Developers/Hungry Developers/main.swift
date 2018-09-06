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
                if leftSpoon.id < rightSpoon.id {
                    leftSpoon.pickUp()
                } else {
                    rightSpoon.pickUp()
                }
                print("\(name) picked up left spoon")
            } else {
                if leftSpoon.id < rightSpoon.id {
                    rightSpoon.pickUp()
                } else {
                    leftSpoon.pickUp()
                }
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
    
    init(id: Int) {
        self.id = id
    }
    
    // MARK: - Properties
    
    let id: Int
    private let lock = NSLock()
    
    
    // MARK: - Methods
    
    func pickUp() {
        lock.lock()
    }
    
    func putDown() {
        lock.unlock()
    }
}


// MARK: - Testing

var spoon1 = Spoon(id: 1)
var spoon2 = Spoon(id: 2)
var spoon3 = Spoon(id: 3)
var spoon4 = Spoon(id: 4)
var spoon5 = Spoon(id: 5)

var developer1 = Developer(name: "Developer1", leftSpoon: spoon1, rightSpoon: spoon2)
var developer2 = Developer(name: "Developer2", leftSpoon: spoon2, rightSpoon: spoon3)
var developer3 = Developer(name: "Developer3", leftSpoon: spoon3, rightSpoon: spoon4)
var developer4 = Developer(name: "Developer4", leftSpoon: spoon4, rightSpoon: spoon5)
var developer5 = Developer(name: "Developer5", leftSpoon: spoon5, rightSpoon: spoon1)

let developers = [developer1, developer2, developer3, developer4, developer5]

for developer in developers {
    DispatchQueue.global().async {
        developer.run()
    }
}

dispatchMain()
