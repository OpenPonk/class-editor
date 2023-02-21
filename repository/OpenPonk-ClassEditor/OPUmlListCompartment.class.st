Class {
	#name : #OPUmlListCompartment,
	#superclass : #OPUmlCompartment,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #rendering }
OPUmlListCompartment >> layoutOwnedElements [

	self ownedElements
		inject:
		self roassalShape encompassingRectangle top + self topPadding
		into: [ :prevHeight :each | 
			each translateTopTo: prevHeight.
			prevHeight + each height ].
	self roassalShape signalUpdate
]

{ #category : #sorting }
OPUmlListCompartment >> sortOwnedElements [

	ownedElements sort: [ :a :b | 
		(a modelElement isStatic and: [ b modelElement isStatic not ]) or: [ 
			(a modelElement isStatic or: [ b modelElement isStatic not ]) and: [ 
				a modelElement name < b modelElement name ] ] ]
]
