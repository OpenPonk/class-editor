"
I am a specialized list compartment used within UML Classes. I explicitly handle the sorting of owned elements (like attributes or operations) according to UML display conventions.
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
				a modelElement name < b modelElement name or: [
					a modelElement name = b modelElement name and: [
						a modelElement uuid < b modelElement uuid ] ] ] ] ]
]
