Class {
	#name : #OPUmlPackageCompartmentableShape,
	#superclass : #OPShape,
	#instVars : [
		'view',
		'separators'
	],
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #'Roassal2 - manipulation' }
OPUmlPackageCompartmentableShape >> createRoassalShape [
	| shape |
	shape := OPUmlPackageShape on: self.
	shape style: self style.
	shape shape
		color: [ :model | model style fillColor ];
		borderColor: self style strokeColor;
		borderWidth: self style strokeWidth.
	shape labelText: [ :model | model modelElement name ].
	shape
		stereotypeText: [ :model | 
			(model modelElement isKindOf: OPUMLProfile)
				ifTrue: [ '«profile»' ]
				ifFalse: [ '' ] ].
	^ shape
]

{ #category : #initialization }
OPUmlPackageCompartmentableShape >> initialize [
	super initialize.
	(sharedStyle := OPDIOpenPonkStyle new)
		fillColor: Color veryVeryLightGray;
		strokeColor: Color black;
		strokeWidth: 1
]

{ #category : #'Roassal2 - updating' }
OPUmlPackageCompartmentableShape >> remove [

	self roassalShape remove.
	view ifNotNil: [ view signalUpdate ].
	view := nil
]

{ #category : #'Roassal2 - updating' }
OPUmlPackageCompartmentableShape >> renderIn: aView [
	view := aView.
	view add: self roassalShape.
	self changed
]

{ #category : #'Roassal2 - updating' }
OPUmlPackageCompartmentableShape >> update [
	view ifNil: [ ^ self ].
	self roassalShape update.
	self updateConnectedEdges
]

{ #category : #'Roassal2 - updating' }
OPUmlPackageCompartmentableShape >> update: aParameter [
"	self figuresDo: [ :each | each update: aParameter ]."
	self update
]
