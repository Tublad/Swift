//
//  main.swift
//  Lesson-5
//  Protocol
//  Created by Евгений Шварцкопф on 18/10/2019.
//
//

import Foundation

enum WindowsCar {
    case open
    case close
}

enum EngineCar {
    case start
    case finish
}

enum NintroOxidues {
    case included
    case notIncluded
}

enum Cargo {
    case load
    case unload
}

protocol Car {
    var mark: String  { get }
    var fabricator: String { get }
    var yearOfIssue: String { get }
    var gasTank: Int { get }
    
    func activeDoor(stage: WindowsCar)
    func activeEngine(stage: EngineCar)
    
}

extension Car {
    
    func activeDoor(stage: WindowsCar) {
        switch stage {
        case .open:
            print("Windows open")
        case .close:
            print("Windows close")
        }
    }
    
    func activeEngine(stage: EngineCar) {
        switch stage {
        case .start:
            print("Engine start work ")
        case .finish:
            print("Engine finish work")
        }
    }
    
}


class SportCar: Car {
    
    var mark: String
    var fabricator: String
    var yearOfIssue: String
    var gasTank: Int
    var maxSpeed: String
    var racing: String
    static var greateSportCar = 0
    
    func includedNO(have: NintroOxidues) {
        switch have {
        case .included:
            print("This a car included NitroOxidues")
        case .notIncluded:
            print("This a car not included NitroOxidues")
        }
    }
    
    init(mark: String, fabricator: String, yearOfIssue: String, gasTank: Int, maxSpeed: String, racing: String) {
        self.mark = mark
        self.fabricator = fabricator
        self.yearOfIssue = yearOfIssue
        self.gasTank = gasTank
        self.maxSpeed = maxSpeed
        self.racing = racing
        SportCar.greateSportCar += 1
    }
    
    static func greateSportCars() {
        print("Sport Car great - \(greateSportCar)")
    }
}

extension SportCar: CustomStringConvertible {
    
    var description: String {
        return "Sport Car - \(mark) : \(yearOfIssue) years old. Fabricator - \(fabricator). Her maximum gas-tank is \(gasTank) litrs! Racing for 100 km is \(racing) and maximum speed \(maxSpeed)"
    }
}

var ferrari = SportCar(mark: "Ferrari 260", fabricator: "Italia", yearOfIssue: "21.09.2016", gasTank: 40, maxSpeed: "276 km/h", racing: "3,4 seconds")
var bugati = SportCar(mark: "Bugati", fabricator: "France", yearOfIssue: "19.06.2018", gasTank: 50, maxSpeed: "414 km/h", racing: "2,5 seconds")
var mazda = SportCar(mark: "Mazda", fabricator: "Japan", yearOfIssue: "21.05.1998", gasTank: 35, maxSpeed: "212 km/h", racing: "5 seconds")


ferrari.includedNO(have: .included)
ferrari.activeDoor(stage: .open)
ferrari.activeEngine(stage: .start)

print(ferrari)

bugati.includedNO(have: .included)
bugati.activeDoor(stage: .close)
bugati.activeEngine(stage: .start)

print(bugati)

mazda.includedNO(have: .notIncluded)
mazda.activeDoor(stage: .close)
mazda.activeEngine(stage: .finish)

print(mazda)

SportCar.greateSportCars()

class TruckCar: Car {
    
    var mark: String
    var fabricator: String
    var yearOfIssue: String
    var gasTank: Int
    var trunk: String
    var distance: String
    static var greateTruckCar = 0
    
    func cargo(stage: Cargo) {
        switch stage {
        case .load:
            print("Currently loading goods")
        case .unload:
            print("Currently unloading goods")
        }
    }
    
    init(mark: String, fabricator: String, yearOfIssue: String, gasTank: Int, trunk: String, distance: String) {
        self.mark = mark
        self.fabricator = fabricator
        self.yearOfIssue = yearOfIssue
        self.gasTank = gasTank
        self.trunk = trunk
        self.distance = distance
        TruckCar.greateTruckCar += 1
    }
    
    static func greateTruckCars() {
        print("Truck car greate - \(greateTruckCar)")
    }
    
}

extension TruckCar: CustomStringConvertible {
    
    var description: String {
        return "Truck Car - \(mark): \(yearOfIssue). Fabricator - \(fabricator). His maximum gas-tank \(gasTank) litrs. Frequent transportation distance \(distance) and maximum immorsion \(trunk)"
    }
}

var volvo = TruckCar(mark: "Volvo", fabricator: "Sweden", yearOfIssue: "08.08.2008", gasTank: 70, trunk: "5,000 kg", distance: "4,000 km")
var daf = TruckCar(mark: "Daf", fabricator: "Netherlands", yearOfIssue: "09.06.2016", gasTank: 100, trunk: "8,000 kg", distance: "6,000 km")
var kamaz = TruckCar(mark: "Kamaz", fabricator: "Russian", yearOfIssue: "07.05.2000", gasTank: 80, trunk: "6,000 kg", distance: "5,000 km")

volvo.activeDoor(stage: .open)
volvo.activeEngine(stage: .start)
volvo.cargo(stage: .load)

print(volvo)

TruckCar.greateTruckCars()

daf.activeEngine(stage: .start)
daf.activeDoor(stage: .open)
daf.cargo(stage: .unload)

print(daf)

kamaz.activeDoor(stage: .open)
kamaz.activeEngine(stage: .start)
kamaz.cargo(stage: .load)

print(kamaz)

TruckCar.greateTruckCars()
