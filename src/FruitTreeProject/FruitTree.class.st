Class {
	#name : 'FruitTree',
	#superclass : 'Object',
	#instVars : [
		'species',
		'age',
		'height',
		'yield',
		'fruitingAge'
	],
	#category : 'FruitTreeProject',
	#package : 'FruitTreeProject'
}

{ #category : 'as yet unclassified' }
FruitTree class >> defaultFruitingAge [ 
    "вік, з якого дерево починає плодоносити"
    ^ 3
]

{ #category : 'as yet unclassified' }
FruitTree class >> species: aString age: aNumber height: h yield: y fruitingAge: f [
   ^ self new
        species: aString;
        age: aNumber;
        height: h;
        yield: y;
        fruitingAge: f;
        yourself.

]

{ #category : 'arithmetic' }
FruitTree >> * aNumber [ 
    ^ self yield * aNumber
]

{ #category : 'arithmetic' }
FruitTree >> + anotherTree [ 
    ^ self yield + anotherTree yield
]

{ #category : 'arithmetic' }
FruitTree >> - anotherTree [ 
    ^ self yield - anotherTree yield


]

{ #category : 'arithmetic' }
FruitTree >> / aNumber [ 
    ^ self yield / aNumber
]

{ #category : 'comparing' }
FruitTree >> < anotherTree [
    ^ self height < anotherTree height

]

{ #category : 'comparing' }
FruitTree >> <= anotherTree [
    ^ (self < anotherTree) or: [ self = anotherTree ]

]

{ #category : 'comparing' }
FruitTree >> = anotherObject [
    self == anotherObject ifTrue: [ ^ true ].
    (anotherObject isKindOf: self class) ifFalse: [ ^ false ].
    ^ species = anotherObject species
        and: [ age = anotherObject age
        and: [ height = anotherObject height
        and: [ yield = anotherObject yield
        and: [ fruitingAge = anotherObject fruitingAge ] ] ] ]

]

{ #category : 'comparing' }
FruitTree >> > anotherTree [
    ^ self height > anotherTree height

]

{ #category : 'comparing' }
FruitTree >> >= anotherTree [
    ^ (self > anotherTree) or: [ self = anotherTree ]

]

{ #category : 'accessing' }
FruitTree >> age [

	^ age
]

{ #category : 'accessing' }
FruitTree >> age: anObject [

	age := anObject
]

{ #category : 'accessing' }
FruitTree >> fruitingAge [

	^ fruitingAge
]

{ #category : 'accessing' }
FruitTree >> fruitingAge: anObject [

	fruitingAge := anObject
]

{ #category : 'as yet unclassified' }
FruitTree >> growOneYear [  
    age := age + 1.
    height := height + 1.

    (self isFruiting)
        ifTrue: [ yield := yield + 10 ].
]

{ #category : 'as yet unclassified' }
FruitTree >> growTwoYears [
    self growOneYear.
    self growOneYear.

]

{ #category : 'testing' }
FruitTree >> hasReachedFruitingAge [
    ^ age >= fruitingAge

]

{ #category : 'comparing' }
FruitTree >> hash [
    | h |
    h := self class hash.
    h := h bitXor: species hash.
    h := h bitXor: age hash.
    h := h bitXor: height hash.
    h := h bitXor: yield hash.
    h := h bitXor: fruitingAge hash.
    ^ h

]

{ #category : 'accessing' }
FruitTree >> height [

	^ height
]

{ #category : 'accessing' }
FruitTree >> height: anObject [

	height := anObject
]

{ #category : 'initialization' }
FruitTree >> initialize [
	super initialize.
	age := 0.
	height := 0.
	yield := 0.
	fruitingAge := 3.

]

{ #category : 'testing' }
FruitTree >> isFruiting [
    ^ age >= fruitingAge
]

{ #category : 'as yet unclassified' }
FruitTree >> moreYieldThan: anotherTree [
    ^ self yield > anotherTree yield
]

{ #category : 'printing' }
FruitTree >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: ' species: '; print: species;
		nextPutAll: ' age: '; print: age;
		nextPutAll: ' height: '; print: height;
		nextPutAll: ' yield: '; print: yield.

]

{ #category : 'accessing' }
FruitTree >> species [

	^ species
]

{ #category : 'accessing' }
FruitTree >> species: anObject [

	species := anObject
]

{ #category : 'as yet unclassified' }
FruitTree >> tallerThan: anotherTree [
    ^ self height > anotherTree height

]

{ #category : 'as yet unclassified' }
FruitTree >> yearPassed [
    self growOneYear
]

{ #category : 'accessing' }
FruitTree >> yield [

	^ yield
]

{ #category : 'accessing' }
FruitTree >> yield: anObject [

	yield := anObject
]

{ #category : 'as yet unclassified' }
FruitTree >> yieldAmount [
    ^ yield

]
