"
I am a controller for an Enumeration
"
Class {
	#name : #OPUmlEnumerationController,
	#superclass : #OPUmlClassifierController,
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #figures }
OPUmlEnumerationController >> adornments [

	^ { (OPUmlIcons literalIcon -> [ 
	   | tool |
	   tool := OPCreationTool new
		           palette: self diagramController editor palette;
		           factory: [ OPUMLEnumerationLiteral new ].
	   self diagramController editor palette selectTool: tool.
	   tool whenCreated: [ :ctrl | 
		   OPRenameElementCommand executeOn: ctrl.
		   ctrl refreshFigure ].
	   tool selectedTargetControllers: { self } ]) }
]

{ #category : #rendering }
OPUmlEnumerationController >> allShowableElements [
	| queue |
	queue := OrderedCollection new.
	queue addAll: self model ownedLiterals.
	^ queue asArray
		select: [ :each | diagramController hasSupportForModel: each ]
]

{ #category : #adding }
OPUmlEnumerationController >> canBeTargetFor: aController [
	^ (aController isKindOf: OPUmlEnumerationLiteralController)
		| (aController isKindOf: OPUmlAssociationController)
]

{ #category : #figures }
OPUmlEnumerationController >> createDiagramElement [
	^ OPUmlClassShape new
		modelElement: self model;
		stereotype: [ #(enumeration) ]
]

{ #category : #model }
OPUmlEnumerationController >> createModel [
	^ self modelClass new
		name: 'Enumeration';
		yourself
]

{ #category : #figures }
OPUmlEnumerationController >> elementsToShowInside [
	^ self model ownedLiterals asSet
]

{ #category : #accessing }
OPUmlEnumerationController >> modelClass [
	^ OPUMLEnumeration
]

{ #category : #accessing }
OPUmlEnumerationController >> modelClassName [
	^ #Enumeration
]
