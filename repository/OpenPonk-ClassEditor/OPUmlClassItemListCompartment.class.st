Class {
	#name : #OPUmlClassItemListCompartment,
	#superclass : #OPUmlListCompartment,
	#category : #'OpenPonk-ClassEditor-Shapes'
}

{ #category : #sorting }
OPUmlClassItemListCompartment >> sortOwnedElements [

	ownedElements sort: [ :a :b | 
		(a modelElement isStatic and: [ b modelElement isStatic not ]) or: [ 
			(a modelElement isStatic or: [ b modelElement isStatic not ]) and: [ 
				a modelElement name < b modelElement name ] ] ]
]
