//
//  main.swift
//  Lesson-7
//  Обработка ошибок
//  Created by Евгений Шварцкопф on 27/10/2019.

import Foundation

enum Immorse: Error {
    case unloadMore
    case loadMore
}

enum ConveyorCar: Error {
    case correctlySymbol
    case notFound
    case yearsOld
    case yearsYoung
    case notModels
}

struct Car {
    var mark: String
    var years: Int
    var model: String
}


class Garage {
    
    var garageCars = [Car(mark: "Opel", years: 2012 , model: "1231AD231F"),
                      Car(mark: "BMW", years: 2019, model: "2131AF1230"),
                      Car(mark: "Mercedez", years: 2015, model: "223100312"),
                      Car(mark: "Volvo", years: 2012, model: "2131GF123d"),
                      Car(mark: "Lada", years: 2015, model: "97823ld32k"),
                      Car(mark: "Lada", years: 2000, model: "3642lk32e"),
                      Car(mark: "Opel", years: 2001, model: "0201k239KL")]
    
    func conveyorCheck(name: String, year: Int) throws  {
        guard name.count != 0 else { throw ConveyorCar.correctlySymbol }
        guard year <= 2019 else { throw ConveyorCar.yearsYoung }
        guard year >= 1940 else { throw ConveyorCar.yearsOld }
        for i in garageCars {
            if i.mark == name && i.years == year {
                print("В данный момент есть автомобиль - \(i.mark) с годом выпуска \(i.years). Ёе модель \(i.model)")
                break
            } else if i.mark == name && i.years != year {
                print("В данный момент есть модель \(i.mark) и её год выпуска \(i.years)!Рассматриваете такой вариант?")
                print("Если заинтересует модель машину \(i.model)")
                break
            } else {
                throw ConveyorCar.notFound
            }
        }
    }
    
    func releaseCar(models: String) throws  {
        guard models.count != 0 else { throw ConveyorCar.notFound}
        var count = 0
        for i in garageCars {
            guard models.count > 0 && models.count < 12 else { throw ConveyorCar.notModels }
            if i.model == models {
                garageCars.remove(at: count)
                print("Поздравляю с покупкой вашего автомобиля \(i.mark) с готодом выпуска \(i.years)")
                continue
            } else {
                count += 1
            }
        }
    }
}

let garage = Garage()

do {
    try garage.conveyorCheck(name: "Volvo", year: 2013)
    try garage.conveyorCheck(name: "BMW", year: 2019)
    try garage.conveyorCheck(name: "", year: 2015)
    try garage.conveyorCheck(name: "Lada", year: 1935)
    try garage.conveyorCheck(name: "LadA", year: 2001)
    try garage.conveyorCheck(name: "Lada", year: 2020)
            
} catch ConveyorCar.correctlySymbol {
    print("Пожалуйста, введите корректные данные автомобиля")
} catch ConveyorCar.notFound {
    print("Данного автомобиля нет в конвейере! Пожалуйста, обратитесь позже.")
} catch ConveyorCar.yearsYoung {
    print("Будующего автомобиля нет! На данный момент самый современный автомобиль это 2019 года")
} catch ConveyorCar.yearsOld {
    print("Такого старого автомобиля не существует или нет в настоящий момент в гараже.")
} catch {
    print("Ошибка сервера")
}


do {
    try garage.releaseCar(models: "")
    try garage.releaseCar(models: "12312asdadsfa1231fasdsa")
    try garage.releaseCar(models: "97823ld32k")
    
} catch ConveyorCar.notFound {
    print("Введите данные модели")
} catch ConveyorCar.notModels {
    print("Не корректно введина модель, пожалуйста повторите попытку!")
} catch {
    print("Ошибка сервера")
}


