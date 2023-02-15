Class {
	#name : #OPUmlFeaturesCompartment,
	#superclass : #OPUmlCompartment,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #sorting }
OPUmlFeaturesCompartment >> sortOwnedElements [

	ownedElements sort: [ :a :b | 
		(a modelElement isStatic and: [ b modelElement isStatic not ]) or: [ 
			(a modelElement isStatic or: [ b modelElement isStatic not ]) and: [ 
				a name < b name ] ] ]
]
