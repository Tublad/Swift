//  Lesson-3

//  Created by Евгений Шварцкопф on 12/10/2019.
//  Copyright © 2019 Евгений Шварцкопф. All rights reserved.


import Foundation

enum WindowsCar {
    case open
    case close
}

enum CarEngine {
    case start
    case finish
}

enum CarTrunk{
    case immorse
    case unload
}

struct Car {
    
    var mark: String
    var yearOfIssue: String
    var trunk: Int
    private var fullBoot = 50
    
    var immorseTrunk: Int {
        get {
            return trunk
        }
        set {
            if newValue < 0 || newValue > fullBoot {
                trunk = 0
                return
            }
            trunk = newValue + trunk
            print("Now immorse in boot volume car \(newValue)")
        }
    }
    
    var leftTrunk: Int {
        get {
            return trunk
        }
        set {
            if newValue < 0 || newValue > fullBoot {
                trunk = 0
                return
            } else if newValue < trunk {
                trunk = trunk - newValue
            } else {
                trunk = newValue - trunk
            }
            print("Now unload is boot volume car \(newValue)")
        }
    }
    
    var engine: CarEngine {
        willSet {
            if newValue == .start {
                print("Engine work")
            } else {
                print("Engine work off")
            }
        }
    }
    
    var doorState: WindowsCar {
        willSet {
            if newValue == .open {
                print("Now windows car is open")
            } else {
                print("Now windows car is close")
            }
        }
    }
    mutating func activeTrunkVolume(stage: CarTrunk) {
        switch stage {
        case .immorse:
            print("In car \(CarTrunk.immorse) \(immorseTrunk) and now in boot car \(trunk) ")
        case .unload:
            print("In car \(CarTrunk.unload) \(leftTrunk) and now in boot car \(trunk) ")
        }
    }
    
    mutating func activeEngineCar(stage: CarEngine) {
        switch stage {
        case .start:
            self.engine = .start
        case .finish:
            self.engine = .finish
        }
    }
    mutating func activeDoorCar(stage: WindowsCar) {
        switch stage {
        case .open:
            self.doorState = .open
        case .close:
            self.doorState = .close
        }
    }
    
    init(mark: String, yearOfIssue: String, trunk: Int, engine: CarEngine, doorState: WindowsCar) {
        self.mark = mark
        self.yearOfIssue = yearOfIssue
        self.trunk = trunk
        self.engine = engine
        self.doorState = doorState
    }
    init(mark: String, yearOfIssue: String, engine: CarEngine, doorState: WindowsCar) {
        self.mark = mark
        self.yearOfIssue = yearOfIssue
        self.trunk = 0
        self.engine = engine
        self.doorState = doorState
    }
    
    init(mark: String, yearOfIssue: String) {
        self.mark = mark
        self.yearOfIssue = yearOfIssue
        self.trunk = 0
        self.engine = .finish
        self.doorState = .close
    }
}

var opel = Car(mark: "Opel", yearOfIssue: "01.10.2019 y.o.")
var bmw = Car(mark: "BMW", yearOfIssue: "21.09.2001 y.o.", trunk: 0, engine: .finish, doorState: .close)
var mercedes = Car(mark: "Mercedes", yearOfIssue: "12.06.1998 y.o.", trunk: 10, engine: .start, doorState: .open)
var toyota = Car(mark: "Toyota", yearOfIssue: "01.11.2001 y.o.", engine: .start, doorState: .close)

opel.doorState = .close
opel.activeEngineCar(stage: .start)
opel.activeDoorCar(stage: .open)
opel.trunk = 5
opel.immorseTrunk = 20
print(opel.trunk)
opel.leftTrunk = 10
print(opel.trunk)
opel.activeTrunkVolume(stage: .immorse)

bmw.immorseTrunk = 15
print(bmw.trunk)
bmw.activeDoorCar(stage: .close)
bmw.activeEngineCar(stage: .finish)
bmw.leftTrunk = 10
print(bmw.trunk)
print(bmw.mark)

print(mercedes.mark)
print(mercedes.yearOfIssue)
print(mercedes.trunk)
print(mercedes.engine)
print(mercedes.doorState)
print(mercedes.immorseTrunk)
print(mercedes.leftTrunk)
mercedes.activeDoorCar(stage: .open)
mercedes.activeEngineCar(stage: .start)
mercedes.activeTrunkVolume(stage: .immorse)




















