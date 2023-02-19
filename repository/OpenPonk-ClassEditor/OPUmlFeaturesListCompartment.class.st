Class {
	#name : #OPUmlFeaturesListCompartment,
	#superclass : #OPUmlListCompartment,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #sorting }
OPUmlFeaturesListCompartment >> sortOwnedElements [

	ownedElements sort: [ :a :b | 
		(a modelElement isStatic and: [ b modelElement isStatic not ]) or: [ 
			(a modelElement isStatic or: [ b modelElement isStatic not ]) and: [ 
				a name < b name ] ] ]
]
