Class {
	#name : 'ApricotTree',
	#superclass : 'FruitTree',
	#instVars : [
		'hadFrosts'
	],
	#category : 'FruitTreeProject',
	#package : 'FruitTreeProject'
}

{ #category : 'as yet unclassified' }
ApricotTree class >> frostRemainingFactor [ 
    "частина врожаю лишається, якщо були заморозки- 20%"
    ^ 0.2
]

{ #category : 'as yet unclassified' }
ApricotTree class >> species: aString age: aNumber height: h yield: y fruitingAge: f hadFrosts: aBoolean [ 
   ^ self new
        species: aString;
        age: aNumber;
        height: h;
        yield: y;
        fruitingAge: f;
        hadFrosts: aBoolean;
        yourself
]

{ #category : 'as yet unclassified' }
ApricotTree >> growOneYear [ 
    | previousYield added |
    previousYield := yield.

    super growOneYear.

    (hadFrosts and: [ yield > previousYield ]) ifTrue: [
        added := yield - previousYield.
        yield := previousYield + (added * self class frostRemainingFactor).
    ].

]

{ #category : 'accessing' }
ApricotTree >> hadFrosts [ 
    ^ hadFrosts

]

{ #category : 'accessing' }
ApricotTree >> hadFrosts: aBoolean [ 
    hadFrosts := aBoolean
]

{ #category : 'initialization' }
ApricotTree >> initialize [ 
    super initialize.
    hadFrosts := false.  

]

{ #category : 'printing' }
ApricotTree >> printOn: aStream [ 
    super printOn: aStream.
    aStream
        nextPutAll: ' hadFrosts: ';
        print: hadFrosts.
]
