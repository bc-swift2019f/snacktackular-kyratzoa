import UIKit

var str = "Hello, playground"


var myarray = [83, 85, 90, 100]

let average = Double(myarray.reduce(0, {$0 + $1 })) / Double(myarray.count)
print(average)
print("")

myarray.forEach({print($0)})

var scoresAfterBonus = myarray.map({Double($0) * 1.1})
scoresAfterBonus.forEach({print($0)})


var evenNumbers = myarray.filter({$0 % 2 == 0})
evenNumbers.forEach({print($0)})
