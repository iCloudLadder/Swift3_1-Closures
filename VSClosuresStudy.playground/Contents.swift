//: Playground - noun: a place where people can play

import UIKit

// >> 闭包(Closures)

/*
 闭包是自包含的函数代码块,可以在代码中被传递和使用。
 Swift 中的闭包与 C 和 Objective-C 中的代码块(blocks)以及其他一些编程语言中的匿名函数比较相似。
 
 闭包可以捕获和存储其所在上下文中任意常量和变量的引用。
 这就是所谓的闭合并包裹着这些常量和变量,又称 闭包。
 Swift 会为您管理在捕获过程中涉及到的所有内存操作。
 
 
 在函数章节中介绍的全局和嵌套函数实际上也是特殊的闭包。
 
 闭包的三种形式：
 • 全局函数是一个有名字但不会捕获任何值的闭包
 • 嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包
 • 闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包
 
 
 闭包优点：
 • 利用上下文推断参数和返回值类型
 • 隐式返回单表达式闭包,即单表达式闭包可以省略 return 关键字 
 • 参数名称缩写
 • 尾随(Trailing)闭包语法

 
 */



// 1. 闭包表达式
/*
 闭包表达式是一种利用简洁语法构建内联闭包的方式。
 闭包表达式提供了一些语法优化,使得撰写闭包变得简单 明了。
 */

// 以  sort(_:) 方法的定义和语法优化的方式 为例
// sort(_:) 需要一个 (T, T) ->Bool 的闭包作为参数
let numbers = [23, 5, 11, 8, 2, 21, 13]

// 方法的 2 个参数类型必须与要排序的数组内保存元素的类型相同
func backwards(s1: Int, s2: Int) -> Bool {
    return s1 > s2
}
numbers.sorted(by: backwards)


//  1.1 闭包表达式的语法
/*
 { (parameters) -> returnType in
    statements
 }
 
 
 闭包表达式语法可以使用常量、变量和 inout 类型作为参数,不能提供默认值。
 也可以在参数列表的最后使用可 变参数。
 元组也可以作为参数和返回值。

 */


// 以把之前的 backwards 函数写成对应的闭包形式
numbers
let afterSort = numbers.sorted(by: { (s1: Int, s2: Int) ->Bool in return s1 > s2})
afterSort
// 闭包的函数体部分由关键字 in 引入。该关键字表示闭包的参数和返回值类型定义已经完成,闭包函数体即将开始。


// 1.2 根据上下文推断类型
/* 
 因为排序闭包函数是作为 sorted(by_:) 方法的参数传入的,Swift 可以推断其参数和返回值的类型。
 
 sorted(by_:) 根据被调用的对象来判断参数的类型。 numbers 调用时，会根据numbers是 存储Int类型的，来推断闭包类型为 (Int, Int) -> Bool, 所以 返回箭头( -> )和 围绕在参数周围的括号也可以被省略:
 */

numbers
let noClosuresType = numbers.sorted(by: { s1, s2 in return s1 > s2 })
noClosuresType



// 1.2 单行表达式闭包隐式返回

// 单行表达式闭包可以通过省略 return 关键字来隐式返回单行表达式的结果
// ** in 后的表达式，必须是单行 return 语句

numbers
let noReturn = numbers.sorted(by: { s1, s2 in s1 > s2 })
noReturn



// 1.3 参数名称缩写
/*
 Swift 自动为内联闭包提供了参数名称缩写功能,您可以直接通过 $0 , $1 , $2 来顺序调用闭包的参数
 
 如果您在闭包表达式中使用参数名称缩写,您可以在闭包参数列表中省略对其的定义,并且对应参数名称缩写的类型会通过函数类型进行推断。
 in 关键字也同样可以被省略,因为此时闭包表达式完全由闭包函数体构成:
 */

numbers
let noParaAndIn = numbers.sorted(by: { $0 > $1 })
noParaAndIn


// 1.4 运算符函数
/*
 实际上还有一种更简短的方式来撰写上面例子中的闭包表达式。
 Swift 的 Int 类型定义了关于大于号( > )的字符串实现,其作为一个函数接受两个 Int 类型的参数并返回 Bool 类型的值。
 而这正好与 sorted(by_:) 方法的第二个参数需要的函数类型相符合。
 因此,您可以简单地传递一个大于号,Swift 可以自动推断出您想使用大于号的字符串函数实现:
 */

numbers
let onlyOperator = numbers.sorted( by: > )




// 2. 尾随闭包
/*
 如果将一个很长的闭包表达式作为最后一个参数传递给函数,可以使用尾随闭包来增强函数的可读性。
 尾随闭包是一个书写在函数括号之后的闭包表达式,函数支持将其作为最后一个参数调用:
 */
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // 函数体部分
}

// 以下是不使用尾随闭包进行函数调用 
someFunctionThatTakesAClosure(closure: {
// 闭包主体部分 
})

// 以下是使用尾随闭包进行函数调用 
someFunctionThatTakesAClosure() {
// 闭包主体部分 
}

numbers
let sortNumbers1 = numbers.sorted() { $0 > $1 }
sortNumbers1

// 若只有闭包一个参数，使用尾随闭包时可以省略 ()
numbers
let sortNumbers2 = numbers.sorted{ $0 > $1 }
sortNumbers2


// Swift 的 Array 类型有一个 map(_:) 方法,其获取一个闭包表达式作为其唯一参数。
//该闭包函数会为数组中的每一个元素调用一次,并返回该元素所映射的值。具体的映射方式和返回值类型由闭包来指定。
let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]

let stringNums = numbers.map { (number) -> String in
    var number = number
    var returnStr = ""
    while number > 0 {
        returnStr = digitNames[number % 10]! + returnStr // ! 号强制解包，因字典取值是 可选类型的
        number = number / 10
    }
    
    return returnStr
}
stringNums






// 3. 捕获值
/*
 闭包可以在其被定义的上下文中捕获常量或变量。
 即使定义这些常量和变量的原作用域已经不存在,闭包仍然可以在闭包函数体内引用和修改这些值。
 
 swift 中,可以捕获值的闭包的最简单形式是嵌套函数,也就是定义在其他函数的函数体内的函数。
 嵌套函数可以捕获其外部函数所有的参数以及定义的常量和变量。
 
 */


func makeIncrementor(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    // 嵌套函数 incre mentor() 从上下文中捕获了两个值, runningTotal 和 amount
    func incrementor() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementor
}
/*
 makeIncrementor 返回类型为 () -> Int 。
 这意味着其返回的是一个函数,而不是一个简单类型的值。
 该函数在每次调用时不接受参数,只返回一个 Int 类型的值。
 
 
 makeIncrementer(forIncrement:) 有一个 类型的参数,其外部参数名为 forIncrement, 内部参数名为 amount, 该参数表示每次 incrementor 被调用时 runningTotal 将要增加的量。
 
 嵌套函数 incrementor 用来执行实际的增加操作。该函数简单地使 runningTotal 增加 amount 并将其返回。
 
 函数incrementer()并没有参数，但是在函数体内访问了 runningTotal 和 amount 变量。
 这是因为它从外围函数捕获了 runningTotal 和 amount 变量的引用。
 捕获引用保证了runningTotal 和 amount 变量在调用完 makeIncrementor 后不会消失，并且保证了在下一次执行 incrementer时，runningTotal依旧存在
 
 ********** 为了优化,如果一个值是不可变的,Swift 可能会改为捕获并保存一份对值的拷贝。
 ********** Swift 也会负责被捕获变量的所有内存管理工作,包括释放不再需要的变量。
 */

let incrementByTen = makeIncrementor(forIncrement: 10)

incrementByTen() // 返回的值为10 
incrementByTen() // 返回的值为20 
incrementByTen() // 返回的值为30


// 创建了另一个 incrementor ,它会有属于它自己的一个全新、独立的 runningTotal 变量的引用:
let incrementBySeven = makeIncrementor(forIncrement: 7)
incrementBySeven()
// 返回的值为7


incrementByTen() // 返回的值为40

// *********** 如果您将闭包赋值给一个类实例的属性,并且该闭包通过访问该实例或其成员而捕获了该实例,您将创建一个在 闭包和该实例间的循环强引用。 之后会有怎么解决此类问题的讲解








// 4. 闭包是引用类型
/* 
 上面的例子中, incrementBySeven 和 incrementByTen 是常量,但是这些常量指向的闭包仍然可以增加其捕获的变 量的值。
 ** 这是因为函数和闭包都是引用类型。
 
 ** 无论您将函数或闭包赋值给一个常量还是变量,您实际上都是将常量或变量的值设置为对应函数或闭包的引用。
 上面的例子中,指向闭包的引用 incrementByTen 是一个常量,而并非闭包内容本身。
 */

// 这也意味着如果您将闭包赋值给了两个不同的常量或变量,两个值都会指向同一个闭包:
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen() // 返回的值为50










// 5. 非逃逸闭包
/*
 当一个闭包作为参数传到一个函数中,但是这个闭包在函数返回之后才被执行,我们称该闭包从函数中逃逸。
 
 当你定义接受闭包作为参数的函数时,你可以在参数名之前标注 @escaping ,用来指明这个闭包是允许“逃逸”出这个函数的。
 将闭包标注 @noescape 能使编译器知道这个闭包的生命周期(译者注:闭包只能在函数体中被执行,不能脱离函数体执行,所以编译器明确知道运行时的上下文),从而可以进行一些比较激进的优化。
 */

func someFunctionWithNoescapeClosure( closure: () -> Void) {
    closure()
}


/*
 一种能使闭包“逃逸”出函数的方法是,将这个闭包保存在一个函数外部定义的变量中。
 
 举个例子,很多启动异 步操作的函数接受一个闭包参数作为 completion handler。这类函数会在异步操作开始之后立刻返回,但是闭包直到异步操作结束后才会被调用。在这种情况下,闭包需要“逃逸”出函数,因为闭包需要在函数返回之后被调 用。
 */

// 例
var completionHandlers: [() -> Void] = []
// 下面的函数接受一个闭包作为参数,该闭包被添加到一个函数外定义的数组中。
// 如果你试图将这个参数标注为 @noescape ,你将会获得一个编译错误。
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

// 将闭包标注为 @noescape 使你能在闭包中隐式地引用 self 。

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNoescapeClosure { x = 200 }
    } }
let instance = SomeClass()
instance.doSomething()
print(instance.x) // prints "200"

completionHandlers.first?()
print(instance.x)
// prints "100"











// 6. 自动闭包
/*
 自动闭包是一种自动创建的闭包,用于包装传递给函数作为参数的表达式。
 
 这种闭包不接受任何参数,当它被调用的时候,会返回被包装在其中的表达式的值。
 这种便利语法让你能够用一个普通的表达式来代替显式的闭包,从而省略闭包的花括号。
 
 自动闭包让你能够延迟求值,因为代码段不会被执行直到你调用这个闭包。
 延迟求值对于那些有副作用(Side Ef fect)和代价昂贵的代码来说是很有益处的,因为你能控制代码什么时候执行。
 */

// 例
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count) // prints "5"

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)  // prints "5"


print("Now serving \(customerProvider())!")  // prints "Now serving Chris!"


print(customersInLine.count) // prints "4"
/*
 尽管在闭包的代码中, customersInLine 的第一个元素被移除了,不过在闭包被调用之前,这个元素是不会被移除的。
 如果这个闭包永远不被调用,那么在闭包里面的表达式将永远不会执行,那意味着列表中的元素永远不会被移除。
 
 请注意, customerProvider 的类型不是 String ,而是 () -> String ,一个没有参数且返回值为 String 的函数
 */

// 将闭包作为参数传递给函数时,你能获得同样的延时求值行为。

customersInLine
func serveCustomer(customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
customersInLine
serveCustomer{ customersInLine.remove(at: 0) }  // prints "Now serving Alex!"
customersInLine


/*
 serveCustomer(_:) 接受一个返回顾客名字的显式的闭包。
 下面这个版本的serveCustomer(_:)完成了相同的操作,不过它并没有接受一个显式的闭包,而是通过将参数标记为 @autoclosure 来接收一个自动闭包。
 现在你可以将该函数当做接受 String 类型参数的函数来调用。customerProvider 参数将自动转化为一个闭包,因为该参数被标记了 @autoclosure 特性。
 */

// customersInLine is ["Ewa", "Barry", "Daniella"]
func serveCustomer( customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serveCustomer(customerProvider :customersInLine.remove(at: 0)) // prints "Now serving Ewa!"

// ****　过度使用 autoclosures 会让你的代码变得难以理解。上下文和函数名应该能够清晰地表明求值是被延迟执行 的。

// @autoclosure 特性暗含了 @noescape 特性,
// 如果想让这个闭包 可以“逃逸”,则应该使用 @autoclosure(escaping) 特性.

customersInLine

var customerProviders: [() -> String] = []
func collectCustomerProviders( customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customerProvider: customersInLine.remove(at: 0))
collectCustomerProviders(customerProvider: customersInLine.remove(at: 0))
print("Collected \(customerProviders.count) closures.") // prints "Collected 2 closures."


for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}


/*
 在上面的代码中, collectCustomerProviders(_:) 函数并没有调用传入的 customerProvider 闭包,而是将闭包追 加到了 customerProviders 数组中。这个数组定义在函数作用域范围外,这意味着数组内的闭包将会在函数返回之 后被调用。因此, customerProvider 参数必须允许“逃逸”出函数作用域。
 */














