Class {
	#name : #OPUmlPackageCompartmentableShape,
	#superclass : #OPUmlShape,
	#instVars : [
		'view',
		'separators'
	],
	#category : 'OpenPonk-ClassEditor-Shapes'
}

{ #category : #'Roassal2 - manipulation' }
OPUmlPackageCompartmentableShape >> createRtElement [
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
	shape showTriangle: [ :model | model modelElement isKindOf: OPUMLModel ].
	^ shape
]

{ #category : #initialization }
OPUmlPackageCompartmentableShape >> initialize [
	super initialize.
	(sharedStyle := OPUmlStyle new)
		fillColor: Color veryVeryLightGray;
		strokeColor: Color black;
		strokeWidth: 1
]

{ #category : #'Roassal2 - updating' }
OPUmlPackageCompartmentableShape >> remove [
	self rtElement view ifNotNil: [ self rtElement remove ].
	view ifNotNil: [ view signalUpdate ].
	view := nil
]

{ #category : #'Roassal2 - updating' }
OPUmlPackageCompartmentableShape >> renderIn: aView [
	view := aView.
	view add: self rtElement.
	self changed
]

{ #category : #'Roassal2 - updating' }
OPUmlPackageCompartmentableShape >> update [
	view ifNil: [ ^ self ].
	self rtElement update.
	self updateConnectedEdges
]

{ #category : #'Roassal2 - updating' }
OPUmlPackageCompartmentableShape >> update: aParameter [
"	self figuresDo: [ :each | each update: aParameter ]."
	self update
]
