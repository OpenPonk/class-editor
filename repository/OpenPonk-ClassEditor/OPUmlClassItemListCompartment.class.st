"
A specialized list compartment within UML classes that handles the ordering and display of class items.
"
Class {
	#name : 'OPUmlClassItemListCompartment',
	#superclass : 'OPUmlListCompartment',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'sorting' }
OPUmlClassItemListCompartment >> sortOwnedElements [

	ownedElements sort: [ :a :b |
			(a modelElement isStatic and: [ b modelElement isStatic not ]) or: [
					(a modelElement isStatic or: [ b modelElement isStatic not ]) and: [
							| nameA nameB |
							nameA := a modelElement name ifNil: [ '' ].
							nameB := b modelElement name ifNil: [ '' ].
							nameA < nameB or: [ nameA = nameB and: [ a modelElement uuid < b modelElement uuid ] ] ] ] ]
]
