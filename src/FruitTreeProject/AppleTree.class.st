Class {
	#name : 'AppleTree',
	#superclass : 'FruitTree',
	#instVars : [
		'fruitColor'
	],
	#category : 'FruitTreeProject',
	#package : 'FruitTreeProject'
}

{ #category : 'initialization' }
AppleTree class >> defaultColor [ 
    "колір яблук"
    ^ 'Red'
]

{ #category : 'as yet unclassified' }
AppleTree class >> species: aString age: aNumber height: h yield: y fruitingAge: f color: c [
   ^ self new
        species: aString;
        age: aNumber;
        height: h;
        yield: y;
        fruitingAge: f;
        fruitColor: c;
        yourself.

]

{ #category : 'accessing' }
AppleTree >> fruitColor [
    ^ fruitColor
]

{ #category : 'accessing' }
AppleTree >> fruitColor: aColor [
    fruitColor := aColor
]

{ #category : 'initialization' }
AppleTree >> initialize [ 
    super initialize.
    fruitColor := self class defaultColor.
]

{ #category : 'testing' }
AppleTree >> isFruiting [ 
    ^ (age >= fruitingAge)
        and: [ (age - fruitingAge) even ]

]

{ #category : 'printing' }
AppleTree >> printOn: aStream [
    super printOn: aStream.
    aStream nextPutAll: ' fruitColor: '; print: fruitColor.

]
