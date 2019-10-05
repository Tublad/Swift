import Foundation

// 1 задание: Решить квадратное уровнение

// 1 вариант
var x = 5

var y = pow(Double(x),2) * 19 + 23 * Double(x)
print(Int(y))

// 2 вариант

func aquation(y: Int) -> Int {
   let x = pow(Double(y), 2) + Double(y) * 10 + 25
    return Int(x)
}

let firstX = aquation(y: 7)
print(firstX)

// на сколько верно понял д/з, решение пришло такое в голову)

// 2 задание: Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.

// 1 вариант

var a: Float = 6.1
var b: Float = 3.2

var h = sqrt(powf(a, 2) + powf(b, 2))
print("Hypotenuse of a right triangle = \(h)")

var s = (a * b) / 2
print("Area of ​​a right triangle = \(s)")

var p = a + b + h
print("The perimeter of a right triangle = \(p)")

// 2 вариант

func rightTriangle(d: Float, c: Float) {
    let hypotenuse = sqrt(powf(d, 2) + powf(c, 2)) // команда sqrt позводяет возвестви в квадратный корень
    let area = (d * c) / 2
    let perimeter = d + c + hypotenuse
    print("Area of ​​a right triangle \(area).\nHypotenuse of a right triangle \(hypotenuse).\nThe perimeter of a right triangle \(perimeter).")
}

rightTriangle(d: 4, c: 7)

// 3 задание: Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.

var period = 5

func contribution(sum: Double, percent: Double) {
    let pr =  percent / 100
    var sumMax = sum + pr
    for _ in 0...period {
        let prAge = sumMax * pr
        sumMax += prAge
        print(Int(sumMax))
   }
    print("In five years you will have \(Int(sumMax))$")
}

contribution(sum: 20000, percent: 10)
contribution(sum: 30000, percent: 8)
