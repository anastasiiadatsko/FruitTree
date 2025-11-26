Class {
	#name : 'FruitOrchard',
	#superclass : 'Object',
	#instVars : [
		'trees'
	],
	#category : 'FruitTreeProject',
	#package : 'FruitTreeProject'
}

{ #category : 'as yet unclassified' }
FruitOrchard class >> loadFromCsvFileNamed: aFileName [
    | stream orchard |
    orchard := self new.
    stream := aFileName asFileReference readStream.

    [
        [ stream atEnd ] whileFalse: [
            | line parts type species age height yield fruitingAge extra tree |
            line := stream nextLine.

            line isEmpty ifFalse: [
                parts := line findTokens: ';'.

                type := parts at: 1.
                species := parts at: 2.
                age := (parts at: 3) asNumber asInteger.
                height := (parts at: 4) asNumber.
                yield := (parts at: 5) asNumber.
                fruitingAge := (parts at: 6) asNumber asInteger.
                extra := parts at: 7.

                tree := nil.

                type = 'AppleTree'
                    ifTrue: [
                        tree := AppleTree
                            species: species
                            age: age
                            height: height
                            yield: yield
                            fruitingAge: fruitingAge
                            color: extra ].

                type = 'ApricotTree'
                    ifTrue: [
                        tree := ApricotTree
                            species: species
                            age: age
                            height: height
                            yield: yield
                            fruitingAge: fruitingAge
                            hadFrosts: (extra asLowercase = 'true') ].

                tree ifNotNil: [ orchard addTree: tree ]
            ]
        ]
    ] ensure: [
        stream close
    ].

    ^ orchard

]

{ #category : 'as yet unclassified' }
FruitOrchard class >> loadFromDatabase: aDatabase [
    ^ aDatabase loadAsOrchard

]

{ #category : 'as yet unclassified' }
FruitOrchard class >> loadFromStonFileNamed: aFileName [
    | stream |
    stream := aFileName asFileReference readStream.
    ^ [ STON fromStream: stream ]
        ensure: [ stream close ]

]

{ #category : 'as yet unclassified' }
FruitOrchard class >> sampleOrchard [ 
    | orchard |
    orchard := self new.

    orchard
        addTree: (AppleTree
            species: 'Apple'
            age: 3
            height: 2
            yield: 5
            fruitingAge: FruitTree defaultFruitingAge
            color: AppleTree defaultColor);
        addTree: (AppleTree
            species: 'Apple'
            age: 5
            height: 3
            yield: 12
            fruitingAge: FruitTree defaultFruitingAge
            color: 'Green');
        addTree: (ApricotTree
            species: 'Apricot'
            age: 4
            height: 2.5
            yield: 8
            fruitingAge: FruitTree defaultFruitingAge
            hadFrosts: false);
        addTree: (ApricotTree
            species: 'Apricot'
            age: 6
            height: 3.2
            yield: 10
            fruitingAge: FruitTree defaultFruitingAge
            hadFrosts: true).

    ^ orchard
]

{ #category : 'adding' }
FruitOrchard >> addTree: aFruitTree [ 
    trees add: aFruitTree
]

{ #category : 'adding' }
FruitOrchard >> addTreeFromDialog [ 
    | ui typeIndex species age height yield fruitingAge color frostIndex hadFrosts tree |

    ui := UIManager default.

    typeIndex := ui
        chooseFrom: #('Apple tree' 'Apricot tree')
        title: 'Choose tree type'.

    typeIndex = 0 ifTrue: [ ^ self ]. 

    species := ui
        request: 'Enter species name:'
        initialAnswer: (typeIndex = 1 ifTrue: [ 'Apple' ] ifFalse: [ 'Apricot' ]).

    age := (ui
    request: 'Enter age (years):'
    initialAnswer: '3') asNumber asInteger.

    height := (ui
        request: 'Enter height:'
        initialAnswer: '2.0') asNumber.

    yield := (ui
        request: 'Enter current yield:'
        initialAnswer: '0') asNumber.

    fruitingAge := (ui
    request: 'Enter fruiting age:'
    initialAnswer: FruitTree defaultFruitingAge printString) asNumber asInteger.

    typeIndex = 1
        ifTrue: [
            color := ui
                request: 'Enter fruit color:'
                initialAnswer: AppleTree defaultColor.
            tree := AppleTree
                species: species
                age: age
                height: height
                yield: yield
                fruitingAge: fruitingAge
                color: color
        ]
        ifFalse: [
            frostIndex := ui
                chooseFrom: #('No frost' 'Frost during blossom')
                title: 'Were there frosts during blossom?'.
            frostIndex = 0 ifTrue: [ ^ self ].

            hadFrosts := frostIndex = 2.

            tree := ApricotTree
                species: species
                age: age
                height: height
                yield: yield
                fruitingAge: fruitingAge
                hadFrosts: hadFrosts
        ].

    self addTree: tree


]

{ #category : 'as yet unclassified' }
FruitOrchard >> allTreesAreFruiting [
    ^ trees isEmpty
        ifTrue: [ false ]
        ifFalse: [ trees allSatisfy: [ :each | each hasReachedFruitingAge ] ]

]

{ #category : 'initialization' }
FruitOrchard >> initialize [ 
    super initialize.
    trees := OrderedCollection new

]

{ #category : 'as yet unclassified' }
FruitOrchard >> mostProductiveTree [ 
    trees isEmpty ifTrue: [ ^ nil ].
    ^ (trees asSortedCollection: [ :a :b | a yield <= b yield ]) last


]

{ #category : 'as yet unclassified' }
FruitOrchard >> oneYearPassed [ 
    trees do: [ :each | each yearPassed ]
]

{ #category : 'printing' }
FruitOrchard >> printOn: aStream [ 
    super printOn: aStream.
    aStream
        nextPutAll: ' (';
        print: trees size;
        nextPutAll: ' trees)';
        cr.
    trees do: [ :each |
        aStream
            tab;
            print: each;
            cr ]
]

{ #category : 'as yet unclassified' }
FruitOrchard >> saveAsCsvToFileNamed: aFileName [
    | stream |
    stream := aFileName asFileReference writeStream.
    [
        trees do: [ :each |
            stream
                nextPutAll: each class name asString; nextPutAll: ';';
                nextPutAll: each species asString; nextPutAll: ';';
                nextPutAll: each age printString; nextPutAll: ';';
                nextPutAll: each height printString; nextPutAll: ';';
                nextPutAll: each yield printString; nextPutAll: ';';
                nextPutAll: each fruitingAge printString; nextPutAll: ';'.

            (each isKindOf: AppleTree)
                ifTrue: [
                    stream nextPutAll: each fruitColor asString
                ]
                ifFalse: [
                    (each isKindOf: ApricotTree)
                        ifTrue: [
                            stream nextPutAll: each hadFrosts printString
                        ]
                        ifFalse: [
                            stream nextPutAll: ''
                        ]
                ].

            stream cr
        ]
    ] ensure: [
        stream close
    ].

]

{ #category : 'as yet unclassified' }
FruitOrchard >> saveAsStonToFileNamed: aFileName [
    | stream |
    stream := aFileName asFileReference writeStream.
    [
        STON put: self onStream: stream
    ] ensure: [
        stream close
    ].
]

{ #category : 'as yet unclassified' }
FruitOrchard >> saveToDatabase: aDatabase [
    ^ aDatabase storeOrchard: self

]

{ #category : 'as yet unclassified' }
FruitOrchard >> tallestTree [ 
    trees isEmpty ifTrue: [ ^ nil ].
    ^ (trees asSortedCollection: [ :a :b | a height <= b height ]) last


]

{ #category : 'as yet unclassified' }
FruitOrchard >> top3MostProductive [ 
    ^ self topMostProductive: 3
]

{ #category : 'as yet unclassified' }
FruitOrchard >> topMostProductive: n [ 
    | sorted limited |
    trees isEmpty ifTrue: [ ^ #() ].

    sorted := trees asSortedCollection: [ :a :b | a yield > b yield ].
    limited := sorted copyFrom: 1 to: (n min: sorted size).
    ^ limited asArray

]

{ #category : 'accessing' }
FruitOrchard >> trees [ 
    ^ trees
]

{ #category : 'as yet unclassified' }
FruitOrchard >> treesUnderHeight: maxHeight [ 
    | newOrchard |
    newOrchard := self class new.
    trees do: [ :each |
        each height <= maxHeight
            ifTrue: [ newOrchard addTree: each ] ].
    ^ newOrchard
]

{ #category : 'as yet unclassified' }
FruitOrchard >> twoYearsPassed [ 
    trees do: [ :each | each growTwoYears ]
]
