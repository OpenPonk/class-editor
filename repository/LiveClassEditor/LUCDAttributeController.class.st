Class {
	#name : 'LUCDAttributeController',
	#superclass : 'OPUmlAttributeController',
	#category : 'LiveClassEditor-Controllers',
	#package : 'LiveClassEditor',
	#tag : 'Controllers'
}

{ #category : 'ui hooks' }
LUCDAttributeController >> buildEditorForm: aForm [
	(aForm addTextInput: 'Name')
		autoAccept: false;
		text: self model name;
		whenTextIsAccepted: [ :newValue | 
			self renameAttribute: self model name to: newValue inClass: self model parentType name.
			self model name: newValue.
			self refreshFigure ]
]

{ #category : 'as yet unclassified' }
LUCDAttributeController >> buildIsClassSideEditorForm: aForm [
	(aForm addCheckbox: 'Is Class-side')
		state: self model isStatic;
		whenChangedDo: [ :val | 
			self model isStatic: val.
			self refreshFigure ]
]

{ #category : 'as yet unclassified' }
LUCDAttributeController >> createAttributeNamed: aName inClass: aModelClassName [
	(RBAddInstanceVariableRefactoring variable: aName class: aModelClassName asClass) execute
]

{ #category : 'as yet unclassified' }
LUCDAttributeController >> figureDoubleClicked [
	| result |
	result := UIManager default request: 'Name' initialAnswer: self model name.
	result
		ifNotNil: [ self renameAttribute: self model name to: result inClass: self model parentType name.
			self model name: result ].
	self refreshFigure
]

{ #category : 'as yet unclassified' }
LUCDAttributeController >> renameAttribute: oldName to: newName inClass: aClassName [
	(RBRenameInstanceVariableRefactoring
		rename: oldName
		to: newName
		in: aClassName asClass
		renameAccessors: true) execute.
	self model parentType methods
		detect: [ :each | each name = oldName ]
		ifFound: [ :each | 
			each name: newName.
			(self diagramController controllerForModel: each) refreshFigure ].
	self model parentType methods
		detect: [ :each | each name = (oldName , ':') ]
		ifFound: [ :each | 
			each name: newName , ':'.
			(self diagramController controllerForModel: each) refreshFigure ]
]
