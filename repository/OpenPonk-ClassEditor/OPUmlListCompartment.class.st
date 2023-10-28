Class {
	#name : #OPUmlListCompartment,
	#superclass : #OPUmlCompartment,
	#category : #'OpenPonk-ClassEditor-Shapes'
}

{ #category : #rendering }
OPUmlListCompartment >> layoutOwnedElements [

	self ownedElements
		inject:
		self roassalShape encompassingRectangle top + self topPadding
		into: [ :prevHeight :each |
			each translateTopTo: prevHeight.
			prevHeight + each height ].
	super layoutOwnedElements.
	self roassalShape signalUpdate
]

{ #category : #sorting }
OPUmlListCompartment >> sortOwnedElements [

	ownedElements sort: [ :a :b | 
		a modelElement name < b modelElement name ]
]
