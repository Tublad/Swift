//
//  main.swift
//  Lesson-6
//
//
//  Дженерики, Сабскрипты, замыкания и функции высшего порядка
//  Created by Евгений Шварцкопф on 23/10/2019.

import Foundation

class People {
    var name: String
    var age: String
    
    init(name: String, age: String) {
        self.name = name
        self.age = age
    }
}

struct Queue<T> {
    var collection = [T]()
    
    mutating func push(_ element: T) {
        collection.append(element)
    }
    
    mutating func pop(_ element: T) -> T {
        return collection.removeFirst()
    }
    
    mutating func filter(_ clouser: (T) -> Bool) -> [T] {
        var array = [T]()
        for element in collection {
            if clouser(element) {
                array.append(element)
            }
        }
        return array
    }
    
    mutating func outFirst(_ clouser: (T) -> Bool) {
        for element in collection {
            if clouser(element) {
                collection.removeFirst()
            }
        }
    }
    
    mutating func sayCount() {
        print(collection.count)
    }
    
    subscript(index: Int) -> T? {
        if index > collection.count  {
            return nil
        }
        return collection[index]
    }
}

var marina = People(name: "Marina", age: "Grandmother")
var andrei = People(name: "Andrei", age: "Grandfather")
var vova = People(name: "Vova", age: "Boy")
var anna = People(name: "Anna", age: "Girl")
var egor = People(name: "Egor", age: "Boy")
var maxim = People(name: "Maxim", age: "Grandfather")
var lena = People(name: "Elena", age: "Grandmother")

var queue = Queue<People>()

queue.push(marina)
queue.push(anna)
queue.push(andrei)
queue.push(egor)
queue.push(maxim)
queue.push(lena)
queue.push(vova)

var filterOld = queue.filter { (people) -> Bool in
    return people.age == "Grandfather" || people.age == "Grandmother"
}

for i in filterOld {
    print(i.age)
}

var filterYoung = queue.filter { (people) -> Bool in
    return people.age == "Girl" || people.age == "Boy"
}

for i in filterYoung {
    print(i.age)
}

 queue.outFirst { (people) -> Bool in
    return people.age == "Grandmother"
}

queue.sayCount()



