//  lesson-2
//  Created by Евгений Шварцкопф on 09/10/2019.

import Foundation
// Написать функцию, которая определяет, четное число или нет.

func checkNumberEven(_ number: Int) {
    (number % 2) == 0 ? print("Это четное число") : print("Это не четное число и имеет остаток")
}

checkNumberEven(4)

// Написать функцию, которая определяет, делится ли число без остатка на 3.

func checkNumberThree(_ number: Int) {
    let checkThree = number % 3
    checkThree == 0 ? print("Это число делится на 3 без остатка") : print("Это число не делится на 3 без остатка и имеет остаток \(checkThree)")
}
checkNumberThree(5)

// Создать возрастающий массив из 100 чисел.

func ascendingArray() -> [Int] {
    var array: [Int] = []
    for i in 1...100{
        array.append(i)
    }
    return array
}
var arrayNumber = ascendingArray()
print(arrayNumber)

// Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

func arrayMining(_ array: inout [Int])  {
    var k = 0
    for i in array {
        if (i % 2) == 0 || (i % 3) != 0 {
            array.remove(at: k)
            continue
        }
        k += 1
    }
    print(array)
}
arrayMining(&arrayNumber)

// * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов.

func addArrayFibonachi(_ array: inout [Int]) {
    for _ in 0...100 {
        let randomNum = Int.random(in:0..<100)
        let numberFibonachi = randomNum - 1 + randomNum - 2
       array.append(numberFibonachi)
    }
    print(array)
}
addArrayFibonachi(&arrayNumber)

//* Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги



