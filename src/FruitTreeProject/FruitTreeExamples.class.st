Class {
	#name : 'FruitTreeExamples',
	#superclass : 'Object',
	#category : 'FruitTreeProject',
	#package : 'FruitTreeProject'
}

{ #category : 'as yet unclassified' }
FruitTreeExamples class >> exampleAddTreeFromDialog [
    | orchard |
    orchard := FruitOrchard sampleOrchard.
    orchard addTreeFromDialog.
    ^ orchard

]

{ #category : 'as yet unclassified' }
FruitTreeExamples class >> exampleArithmeticAndComparisons [
    | orchard t1 t2 results |
    orchard := FruitOrchard sampleOrchard.
    t1 := orchard trees first.
    t2 := orchard trees second.

    results := Dictionary new.
    results
        at: #tree1 put: t1;
        at: #tree2 put: t2;
        at: #t1LessThanT2 put: (t1 < t2);
        at: #t1GreaterThanT2 put: (t1 > t2);
        at: #t1EqualsT2 put: (t1 = t2);
        at: #sumYield put: (t1 + t2);          
        at: #diffYield put: (t1 - t2);         
        at: #doubleYieldT1 put: (t1 * 2);      
        at: #halfYieldT2 put: (t2 / 2).     

    ^ results

]

{ #category : 'as yet unclassified' }
FruitTreeExamples class >> exampleBasicOperations [
    | orchard results |
    orchard := FruitOrchard sampleOrchard.

    results := Dictionary new.
    results
        at: #orchard put: orchard;
        at: #tallestTree put: orchard tallestTree;
        at: #mostProductiveTree put: orchard mostProductiveTree;
        at: #top3MostProductive put: orchard top3MostProductive;
        at: #allTreesAreFruiting put: orchard allTreesAreFruiting;
        at: #treesUnderHeight3 put: (orchard treesUnderHeight: 3).

    orchard oneYearPassed.
    results at: #orchardAfterOneYear put: orchard copy.

    orchard twoYearsPassed.
    results at: #orchardAfterThreeYears put: orchard.

    ^ results

]

{ #category : 'as yet unclassified' }
FruitTreeExamples class >> exampleDatabasePersistence [
    | orchard db orchardFromDb results |
    orchard := FruitOrchard sampleOrchard.
    db := FruitTreeDatabase new.

    orchard saveToDatabase: db.
    orchardFromDb := FruitOrchard loadFromDatabase: db.

    results := Dictionary new.
    results
        at: #database put: db;
        at: #orchardOriginal put: orchard;
        at: #orchardFromDb put: orchardFromDb;
        at: #mostProductiveFromDb put: orchardFromDb mostProductiveTree.

    ^ results

]

{ #category : 'as yet unclassified' }
FruitTreeExamples class >> exampleFilePersistence [

    | orchard orchardFromCsv orchardFromSton results |
    orchard := FruitOrchard sampleOrchard.

    orchard saveAsCsvToFileNamed: 'orchard.csv'.
    orchard saveAsStonToFileNamed: 'orchard.ston'.

    orchardFromCsv := FruitOrchard loadFromCsvFileNamed: 'orchard.csv'.
    orchardFromSton := FruitOrchard loadFromStonFileNamed: 'orchard.ston'.

    results := Dictionary new.
    results
        at: #original put: orchard;
        at: #fromCsv put: orchardFromCsv;
        at: #fromSton put: orchardFromSton.

    ^ results

]

{ #category : 'as yet unclassified' }
FruitTreeExamples class >> exampleSampleOrchard [
    ^ FruitOrchard sampleOrchard

]
