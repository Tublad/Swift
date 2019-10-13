//  Lesson-3

//  Created by Евгений Шварцкопф on 12/10/2019.
//  Copyright © 2019 Евгений Шварцкопф. All rights reserved.


import Foundation

// Легковая машина Car

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

// Грузовая машина Truck

enum WindowTruck {
    case open
    case close
}
enum EngineTruck {
    case start
    case finish
}
enum TruckTrunk {
    case immorse
    case unload
}

struct Truck {
    var marka: String
    var yearOld: String
    var trunks: Int
    private let fullBoot = 1000
    
    var trunkImmorse: Int {
        get {
            return trunks
        }
        set {
            if newValue < 0 || newValue > fullBoot {
                trunks = 0
            }
            trunks = trunks + newValue
            print("In Truck \(TruckTrunk.immorse) at \(newValue) and all volume trunk \(trunks)")
        }
    }
    var trunkUnload: Int  {
        get {
            return trunks
        }
        set {
            if newValue < 0 || newValue > fullBoot {
                trunks = 0
            } else if newValue > trunks {
                trunks = newValue - trunks
            } else {
                trunks = trunks - newValue
            }
            print("In Truck \(TruckTrunk.unload) at \(newValue) and all volume trunk \(trunks)")
        }
    }
    
    var doorAction: WindowTruck {
        willSet {
            if newValue == .open {
                print("In truck is open windows")
            } else {
                print("In truck is close windows")
            }
        }
        didSet {
            if oldValue == .close {
                print("In truck in close windows")
            } else {
                print("In truck in open windows")
            }
        }
    }
    
    var engineAction: EngineTruck {
        willSet {
            if newValue == .start {
                print("Truck is start work engine and ready go out")
            } else {
                print("Truck is finish work engine and stop at now")
            }
        }
    }
    
    mutating func stageEngine(stage: EngineTruck) {
        switch stage {
        case .start:
            self.engineAction = .start
            print(engineAction)
        case .finish:
            self.engineAction = .finish
            print(engineAction)
        }
    }
    mutating func stageDoor(stage: WindowTruck) {
        switch stage {
        case .open:
            self.doorAction = .open
            print(doorAction)
        case .close:
            self.doorAction = .close
            print(doorAction)
        }
    }
    
    init(marka: String, yearOld: String, trunks: Int) {
        self.marka = marka
        self.yearOld = yearOld
        self.trunks = trunks
        self.doorAction = .close
        self.engineAction = .finish
    }
    init(marka: String, yearOld: String) {
        self.marka = marka
        self.yearOld = yearOld
        self.trunks = 0
        self.doorAction = .open
        self.engineAction = .start
    }
}

var volvo = Truck(marka: "Volvo", yearOld: "21.09.2001 y.o.", trunks: 500)
var daf = Truck(marka: "Daf", yearOld: "19.01.2008", trunks: 250)
var scanio = Truck(marka: "Scanio", yearOld: "10.10.2019")

volvo.stageEngine(stage: .finish)
volvo.stageDoor(stage: .open)
volvo.trunkImmorse = 400
volvo.trunkUnload = 100
print(volvo.marka)
print(volvo.yearOld)
print(volvo.trunks)
print(volvo.doorAction)
print(volvo.engineAction)

daf.stageDoor(stage: .open)
daf.engineAction = .start
daf.trunkImmorse = 500
print(daf.trunks)
print(daf.marka)
print(daf.yearOld)
print(daf.trunks)
print(daf.engineAction)
print(daf.doorAction)









