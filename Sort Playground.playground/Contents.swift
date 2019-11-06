import UIKit

//var favoriteFoods = ["Pizza", "Apple Pie", "Sushi", "Ice Cream"]
//
//
//let aToZFoods = favoriteFoods.sorted(by: <)
//print(aToZFoods)
//
//let zToAFoods = favoriteFoods.sorted(by: >)
//print(zToAFoods)
//print(favoriteFoods)
//
//favoriteFoods.sort(by: <)
//print(favoriteFoods)


struct  Foods{
    var name = ""
    var type = ""
}

var foods = [Foods]()
foods.append(Foods(name:"Carrot", type: "Vegetable"))
foods.append(Foods(name:"Bacon", type: "Meat"))
foods.append(Foods(name:"Almond", type: "Nut"))
foods.append(Foods(name:"Ice Cream", type: "Dairy"))

foods.sort(by: {$0.name < $1.name})
for food in foods{
    print(food.name, food.type)
}
foods.sort(by: {$0.name > $1.name})
for food in foods{
    print(food.name, food.type)
}

foods.sort(by: {$0.type < $1.type})
for food in foods{
    print(food.name, food.type)
}
