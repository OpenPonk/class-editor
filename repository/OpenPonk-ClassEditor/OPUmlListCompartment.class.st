Class {
	#name : #OPUmlListCompartment,
	#superclass : #OPUmlCompartment,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #rendering }
OPUmlListCompartment >> layoutOwnedElements [

	^ self ownedElements
		  inject:
		  self roassalShape encompassingRectangle top + self topPadding
		  into: [ :prevHeight :each | 
			  each translateTopTo: prevHeight.
			  prevHeight + each height ]
]
