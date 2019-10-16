
//  main.swift
//  Lesson-4
//  Class
//  Created by Евгений Шварцкопф on 16/10/2019.



enum CarEngine {
    case start
    case finish
}

enum Cargo {
    case immorse
    case unload
}

enum NitrousOxide {
    case included
    case notIncluded
}

class Car {
    
    var mark: String
    var yearOfIssue: String
    var numberOfPeople: Int
    
    var engine: CarEngine {
        willSet {
            if newValue == .start {
                print("Engine work")
            } else {
                print("Engine work off")
            }
        }
    }
    
    func presentCar() {
        print(mark + " " + yearOfIssue)
    }
    
    func NumberOfPlace() {
        print("Numbers of place in car - \(numberOfPeople)")
    }
    
    init(mark: String, yearOfIssue: String, numberOfPeople: Int, engine: CarEngine) {
        self.mark = mark
        self.yearOfIssue = yearOfIssue
        self.numberOfPeople = numberOfPeople
        self.engine = .finish
    }
}

class SportCar: Car {
    var volume: String
    var maxSpeed: String
    var nitrousOxide: NitrousOxide
    static var greateSportCar = 0
    
    func checkNitro() {
        nitrousOxide == .included ?
            print("Included NO in car") : print("Not included NO in car")
    }
    
    override func presentCar() {
        print("Sport car is \(mark)! Maximum speed \(maxSpeed) and volume \(volume)")
    }
    
    init(mark: String, yearOfIssue: String, numberOfPeople: Int, engine: CarEngine, volume: String, maxSpeed: String, nitrousOxide: NitrousOxide) {
        self.volume = volume
        self.maxSpeed = maxSpeed
        self.nitrousOxide = nitrousOxide
        super.init(mark: mark, yearOfIssue: yearOfIssue, numberOfPeople: numberOfPeople, engine: .finish)
        
        SportCar.greateSportCar += 1
    }
    
    static func greateSportCars(){
        print("Great sport car - \(greateSportCar)")
    }
}

class TruckCar: Car {
    var trunk: String
    var distance: String
    var cargo: Cargo
    static var greatTruckCar = 0
    
    func stageCargoTrack(stage: Cargo) {
        switch stage {
        case .immorse:
            print("Currently loading goods")
        case .unload:
            print("Currently unloading goods")
        }
    }
    
    override func presentCar() {
        print("Truck car - \(mark). His work a point 'A' in point 'B',distance = \(distance) and volume cargo = \(trunk)")
    }
    
    init(mark: String, yearOfIssue: String, numberOfPeople: Int, engine: CarEngine, trunk: String,
         distance: String) {
        self.trunk = trunk
        self.distance = distance
        self.cargo = .immorse
        super.init(mark: mark, yearOfIssue: yearOfIssue, numberOfPeople: numberOfPeople, engine: .finish)
        
        TruckCar.greatTruckCar += 1
    }
    
    static func greatTruckCars() {
        print("Truck car great = \(greatTruckCar)")
    }
}

var opel = Car(mark: "Opel", yearOfIssue: "21.09.2010", numberOfPeople: 4, engine: .start)
var lada = Car(mark: "Lada", yearOfIssue: "06.06.2006", numberOfPeople: 4, engine: .start)

opel.engine = .finish
opel.presentCar()
opel.NumberOfPlace()
print(opel.mark)
print(opel.yearOfIssue)

var lamborgini = SportCar(mark: "Lamborgini", yearOfIssue: "01.11.2019", numberOfPeople: 2, engine: .start,
                          volume: "6 litr", maxSpeed: "378 km/h", nitrousOxide: .included)
var bugati = SportCar(mark: "Bugati", yearOfIssue: "01.12.2018", numberOfPeople: 2, engine: .start,
                      volume: "8 litr",maxSpeed: "459 km/h", nitrousOxide: .included)

lamborgini.engine = .finish
lamborgini.nitrousOxide = .notIncluded
lamborgini.presentCar()
lamborgini.checkNitro()
lamborgini.NumberOfPlace()
print(lamborgini.mark)
print(lamborgini.yearOfIssue)
print(lamborgini.numberOfPeople)

SportCar.greateSportCars()

var volvo = TruckCar(mark: "Volvo", yearOfIssue: "08.07.2013", numberOfPeople: 3, engine: .start,
                     trunk: "4,000 kg",distance: "5,000 km")
var kamaz = TruckCar(mark: "Kamaz", yearOfIssue: "02.04.2004", numberOfPeople: 3, engine: .finish,
                     trunk: "2,000 kg",distance: "3,000 km")

kamaz.engine = .finish
kamaz.stageCargoTrack(stage: .immorse)
kamaz.presentCar()
kamaz.NumberOfPlace()
print(kamaz.mark)
print(kamaz.yearOfIssue)
print(kamaz.distance)
print(kamaz.cargo)
print(kamaz.trunk)

TruckCar.greatTruckCars()
