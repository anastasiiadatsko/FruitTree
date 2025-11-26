Class {
	#name : 'FruitTreeDatabase',
	#superclass : 'Object',
	#instVars : [
		'treesById',
		'nextId'
	],
	#category : 'FruitTreeProject',
	#package : 'FruitTreeProject'
}

{ #category : 'as yet unclassified' }
FruitTreeDatabase >> allTrees [
    ^ treesById values asOrderedCollection

]

{ #category : 'accessing' }
FruitTreeDatabase >> clear [
    treesById removeAll.
    nextId := 1.

]

{ #category : 'initialization' }
FruitTreeDatabase >> initialize [
    super initialize.
    treesById := Dictionary new.
    nextId := 1.

]

{ #category : 'as yet unclassified' }
FruitTreeDatabase >> insertTree: aFruitTree [
    | id |
    id := nextId.
    treesById at: id put: aFruitTree.
    nextId := nextId + 1.
    ^ id

]

{ #category : 'as yet unclassified' }
FruitTreeDatabase >> loadAsOrchard [
    | orchard |
    orchard := FruitOrchard new.
    treesById values do: [ :each |
        orchard addTree: each ].
    ^ orchard

]

{ #category : 'printing' }
FruitTreeDatabase >> printOn: aStream [
    super printOn: aStream.
    aStream
        nextPutAll: ' FruitTreeDatabase(';
        print: self size;
        nextPutAll: ' trees)'.

]

{ #category : 'removing' }
FruitTreeDatabase >> removeTreeAtId: anId [
    treesById removeKey: anId ifAbsent: [ nil ].

]

{ #category : 'accessing' }
FruitTreeDatabase >> size [
    ^ treesById size

]

{ #category : 'as yet unclassified' }
FruitTreeDatabase >> storeOrchard: anOrchard [
    | before |
    before := self size.
    anOrchard trees do: [ :each | self insertTree: each ].
    ^ self size - before

]

{ #category : 'as yet unclassified' }
FruitTreeDatabase >> treeAtId: anId [
    ^ treesById at: anId ifAbsent: [ nil ]

]
