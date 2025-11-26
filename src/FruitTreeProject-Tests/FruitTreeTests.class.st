Class {
	#name : 'FruitTreeTests',
	#superclass : 'TestCase',
	#category : 'FruitTreeProject-Tests',
	#package : 'FruitTreeProject-Tests'
}

{ #category : 'initialization' }
FruitTreeTests class >> initializeTests [
    FruitTreeTests compile: '
testFruitTreeBasics
    | tree1 tree2 |
    tree1 := FruitTree species: ''Generic'' age: 2 height: 3 yield: 10 fruitingAge: 3.
    tree2 := FruitTree species: ''Generic'' age: 4 height: 5 yield: 20 fruitingAge: 3.
    tree1 growOneYear.
    self assert: (tree1 age = 3).
    self assert: (tree1 height = 4).
    self assert: (tree1 yield = 20).
    self assert: tree1 isFruiting.
    self deny: (FruitTree species: ''X'' age: 1 height: 1 yield: 0 fruitingAge: 3) isFruiting.
    self deny: (AppleTree species: ''Apple'' age: 3 height: 2 yield: 5 fruitingAge: 3 color: ''Red'' = tree1).
    self assert: (tree1 + tree2 = 40).
    self assert: (tree1 - tree2 = 0).
    self assert: (tree1 * 2 = 40).
    self assert: (tree2 / 2 = 10).
    self assert: (tree2 > tree1).
    self assert: (tree1 < tree2).
    self assert: (tree1 <= tree2).
    self deny: (tree1 = tree2).
' classified: 'FruitTreeTests'.

    FruitTreeTests compile: '
testAppleTreeFruitingCycle
    | apple |
    apple := AppleTree species: ''Fuji'' age: 2 height: 1 yield: 0 fruitingAge: 3 color: ''Red''.
    apple growOneYear.
    self assert: apple isFruiting.
    self assert: apple yield equals: 10.
    apple growOneYear.
    self deny: apple isFruiting.
    self assert: apple yield equals: 10.
    apple growOneYear.
    self assert: apple isFruiting.
    self assert: apple yield equals: 20.
' classified: 'AppleTreeTests'.

    FruitTreeTests compile: '
testApricotTreeExactFrostLoss
    | apricot oldYield |
    apricot := ApricotTree species: ''Apricot'' age: 3 height: 2 yield: 10 fruitingAge: 3 hadFrosts: true.
    oldYield := apricot yield.
    apricot growOneYear.
    self assert: apricot age equals: 4.
    self assert: apricot yield equals: 12.0.
    apricot := ApricotTree species: ''Apricot'' age: 3 height: 2 yield: 10 fruitingAge: 3 hadFrosts: false.
    apricot growOneYear.
    self assert: apricot yield equals: 20.
' classified: 'ApricotTreeTests'.

    FruitTreeTests compile: '
testFruitOrchardComplete
    | orchard apple apricot apple2 |
    orchard := FruitOrchard new.
    apple := AppleTree species: ''Apple'' age: 3 height: 2 yield: 5 fruitingAge: 3 color: ''Red''.
    apricot := ApricotTree species: ''Apricot'' age: 4 height: 3 yield: 8 fruitingAge: 3 hadFrosts: false.
    apple2 := AppleTree species: ''Young'' age: 1 height: 1 yield: 0 fruitingAge: 3 color: ''Green''.
    orchard addTree: apple.
    orchard addTree: apricot.
    orchard addTree: apple2.
    self assert: (orchard tallestTree = apricot).
    self assert: (orchard mostProductiveTree = apricot).
    self deny: orchard allTreesAreFruiting.
    orchard oneYearPassed.
    self assert: (apple age = 4).
    self assert: (orchard top3MostProductive size = 3).
    self assert: (orchard top3MostProductive includes: apricot).
    self assert: ((orchard treesUnderHeight: 2) trees size = 1).
    self assert: ((orchard treesUnderHeight: 3) trees size = 2).
' classified: 'FruitOrchardTests'.

    FruitTreeTests compile: '
testSaveAndLoadCsv
    | orchard loadedOrchard fileName |
    fileName := ''tempOrchard.csv''.
    orchard := FruitOrchard sampleOrchard.
    orchard saveAsCsvToFileNamed: fileName.
    loadedOrchard := FruitOrchard loadFromCsvFileNamed: fileName.
    self assert: (loadedOrchard trees size = orchard trees size).
' classified: 'PersistenceTests'.
]

{ #category : 'tests' }
FruitTreeTests >> testAppleTreeColor [
    | apple |
    apple := AppleTree species: 'Fuji' age: 1 height: 1 yield: 0 fruitingAge: 3 color: 'Red'.

    self assert: (apple fruitColor = 'Red').

]

{ #category : 'tests' }
FruitTreeTests >> testAppleTreeFruitingCycle [
    | apple |
    apple := AppleTree species: 'Fuji' age: 2 height: 1 yield: 0 fruitingAge: 3 color: 'Red'.

    apple growOneYear.
    self assert: apple isFruiting.
    self assert: apple yield equals: 10.

    apple growOneYear.
    self deny: apple isFruiting.
    self assert: apple yield equals: 10.

    apple growOneYear.
    self assert: apple isFruiting.
    self assert: apple yield equals: 20.

]

{ #category : 'tests' }
FruitTreeTests >> testApricotTreeExactFrostLoss [
    | apricot |
    apricot := ApricotTree species: 'Apricot' age: 3 height: 2 yield: 10 fruitingAge: 3 hadFrosts: true.

    apricot growOneYear.
    self assert: apricot age equals: 4.
    self assert: apricot yield equals: 12.0.

    apricot := ApricotTree species: 'Apricot' age: 3 height: 2 yield: 10 fruitingAge: 3 hadFrosts: false.
    apricot growOneYear.
    self assert: apricot yield equals: 20.

]

{ #category : 'tests' }
FruitTreeTests >> testArithmetic [
	| t1 t2 |
	t1 := FruitTree species: 'A' age: 2 height: 3 yield: 10 fruitingAge: 3.
	t2 := FruitTree species: 'B' age: 3 height: 4 yield: 20 fruitingAge: 3.

	self assert: (t1 + t2) equals: 30.
	self assert: (t2 - t1) equals: 10.
	self assert: (t1 * 2) equals: 20.
	self assert: (t2 / 2) equals: 10.

]

{ #category : 'tests' }
FruitTreeTests >> testComparison [
	| t1 t2 t3 |
	t1 := FruitTree species: 'A' age: 1 height: 2 yield: 3 fruitingAge: 3.
	t2 := FruitTree species: 'B' age: 3 height: 5 yield: 7 fruitingAge: 3.
	t3 := FruitTree species: 'C' age: 1 height: 2 yield: 3 fruitingAge: 3.

	self assert: t2 > t1.
	self assert: t1 < t2.
	self assert: t1 <= t3.
	self assert: t1 >= t3.

]

{ #category : 'tests' }
FruitTreeTests >> testEmptyOrchard [
    | orchard |
    orchard := FruitOrchard new.
    self assert: (orchard tallestTree = nil).
    self deny: orchard allTreesAreFruiting.
    self assert: (orchard top3MostProductive isEmpty).
]

{ #category : 'tests' }
FruitTreeTests >> testFruitOrchardComplete [
    | orchard apple apricot apple2 |
    orchard := FruitOrchard new.

    apple := AppleTree species: 'Apple' age: 3 height: 2 yield: 5 fruitingAge: 3 color: 'Red'.
    apricot := ApricotTree species: 'Apricot' age: 4 height: 3 yield: 8 fruitingAge: 3 hadFrosts: false.
    apple2 := AppleTree species: 'Young' age: 1 height: 1 yield: 0 fruitingAge: 3 color: 'Green'.

    orchard addTree: apple.
    orchard addTree: apricot.
    orchard addTree: apple2.

    self assert: orchard tallestTree equals: apricot.
    self assert: orchard mostProductiveTree equals: apricot.
    self deny: orchard allTreesAreFruiting.

    orchard oneYearPassed.

    self assert: apple age equals: 4.
    self assert: orchard top3MostProductive size equals: 3.
    self assert: (orchard top3MostProductive includes: apricot).

    self assert: ((orchard treesUnderHeight: 2) trees size) equals: 1.
    self assert: ((orchard treesUnderHeight: 3) trees size) equals: 2.

]

{ #category : 'tests' }
FruitTreeTests >> testFruitTreeBasics [
    | tree1 tree2 |
    tree1 := FruitTree species: 'Generic' age: 2 height: 3 yield: 10 fruitingAge: 3.
    tree2 := FruitTree species: 'Generic' age: 4 height: 5 yield: 20 fruitingAge: 3.

    tree1 growOneYear.

    self assert: tree1 age equals: 3.
    self assert: tree1 height equals: 4.
    self assert: tree1 yield equals: 20.
    self assert: tree1 isFruiting.

    self deny: (FruitTree species: 'X' age: 1 height: 1 yield: 0 fruitingAge: 3) isFruiting.

    self deny: (AppleTree species: 'Apple' age: 3 height: 2 yield: 5 fruitingAge: 3 color: 'Red') = tree1.

    self assert: (tree1 + tree2) equals: 40.
    self assert: (tree1 - tree2) equals: 0.
    self assert: (tree1 * 2) equals: 40.
    self assert: (tree2 / 2) equals: 10.

    self assert: tree2 > tree1.
    self assert: tree1 < tree2.
    self assert: tree1 <= tree2.

    self deny: tree1 = tree2.

]

{ #category : 'tests' }
FruitTreeTests >> testGrowOneYear [
	| tree |
	tree := FruitTree species: 'A' age: 1 height: 2 yield: 0 fruitingAge: 3.

	tree growOneYear.

	self assert: tree age equals: 2.
	self assert: tree height equals: 3.
	self assert: tree yield equals: 0.

]

{ #category : 'tests' }
FruitTreeTests >> testGrowTwoYears [
    | tree |
    tree := FruitTree species: 'Generic' age: 2 height: 3 yield: 10 fruitingAge: 3.
    tree growOneYear.
    tree growOneYear.
    self assert: (tree age = 4). "2 роки пройшло"
    self assert: (tree height = 5).

]

{ #category : 'tests' }
FruitTreeTests >> testIsFruiting [
	| tree |
	tree := FruitTree species: 'A' age: 2 height: 3 yield: 5 fruitingAge: 3.
	self deny: tree isFruiting.

	tree growOneYear.
	self assert: tree isFruiting.

]

{ #category : 'tests' }
FruitTreeTests >> testOrchardTwoYearsPassed [
    | orchard apple apricot |
    orchard := FruitOrchard new.
    apple := AppleTree species: 'Apple' age: 2 height: 2 yield: 5 fruitingAge: 3 color: 'Red'.
    apricot := ApricotTree species: 'Apricot' age: 3 height: 3 yield: 8 fruitingAge: 3 hadFrosts: false.
    orchard addTree: apple.
    orchard addTree: apricot.
    orchard oneYearPassed.
    orchard oneYearPassed.
    self assert: (apple age = 4).
    self assert: (apricot age = 5).
]

{ #category : 'tests' }
FruitTreeTests >> testPrintOn [
    | tree stream text |
    tree := FruitTree species: 'A' age: 2 height: 3 yield: 5 fruitingAge: 3.
    stream := WriteStream on: String new.

    tree printOn: stream.
    text := stream contents.

    self assert: (text includesSubstring: 'species').
    self assert: (text includesSubstring: 'A').
    self assert: (text includesSubstring: 'age').
    self assert: (text includesSubstring: '2').
    self assert: (text includesSubstring: 'height').
    self assert: (text includesSubstring: '3').
    self assert: (text includesSubstring: 'yield').
    self assert: (text includesSubstring: '5').

]

{ #category : 'tests' }
FruitTreeTests >> testSaveAndLoadCsv [
    | orchard loadedOrchard fileName |
    fileName := 'tempOrchard.csv'.

    orchard := FruitOrchard sampleOrchard.
    orchard saveAsCsvToFileNamed: fileName.

    loadedOrchard := FruitOrchard loadFromCsvFileNamed: fileName.

    self assert: loadedOrchard trees size equals: orchard trees size.

]

{ #category : 'tests' }
FruitTreeTests >> testSaveAndLoadSton [
    | orchard loadedOrchard fileName |
    fileName := 'tempOrchard.ston'.
    orchard := FruitOrchard sampleOrchard.
    orchard saveAsStonToFileNamed: fileName.
    loadedOrchard := FruitOrchard loadFromStonFileNamed: fileName.
    self assert: (loadedOrchard trees size = orchard trees size).
]

{ #category : 'tests' }
FruitTreeTests >> testTopNProductiveLessThanN [
    | orchard apple |
    orchard := FruitOrchard new.
    apple := AppleTree species: 'Apple' age: 2 height: 2 yield: 5 fruitingAge: 3 color: 'Red'.
    orchard addTree: apple.
   self assert: ((orchard topMostProductive: 3) size = 1).

]
