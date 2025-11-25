Class {
	#name : 'AppleTree',
	#superclass : 'FruitTree',
	#instVars : [
		'fruitColor'
	],
	#category : 'FruitTreeProject',
	#package : 'FruitTreeProject'
}

{ #category : 'as yet unclassified' }
AppleTree class >> species: aString age: aNumber height: h yield: y fruitingAge: f color: c [
   ^ self new
        species: aString;
        age: aNumber;
        height: h;
        yield: y;
        fruitingAge: f;
        color: c;
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

{ #category : 'as yet unclassified' }
AppleTree >> growOneYear [
    super growOneYear.

    (age even)
        ifTrue: [ yield := yield + 10 ].

]

{ #category : 'initialization' }
AppleTree >> initialize [
    super initialize.
    fruitColor := 'Red'. 
]

{ #category : 'printing' }
AppleTree >> printOn: aStream [
    super printOn: aStream.
    aStream nextPutAll: ' fruitColor: '; print: fruitColor.

]
