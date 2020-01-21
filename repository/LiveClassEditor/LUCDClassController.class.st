Class {
	#name : #LUCDClassController,
	#superclass : #OPUmlClassController,
	#category : 'LiveClassEditor-Controllers'
}

{ #category : #'ui hooks' }
LUCDClassController >> buildEditorForm: aForm [
	(aForm addTextInput: 'Name')
		autoAccept: false;
		text: self model name;
		whenTextIsAccepted: [ :newValue | 
			self renameClass: self model name to: newValue.
			self model name: newValue.
			self refreshFigure ]
]

{ #category : #'ui hooks' }
LUCDClassController >> createClassFor: aModelClass [
	(RBAddClassRefactoring
		addClass: aModelClass name
		superclass: Object
		subclasses: #()
		category: aModelClass mooseModel name asSymbol) execute
]

{ #category : #'ui hooks' }
LUCDClassController >> renameClass: anOldName to: aNewName [
	(RBRenameClassRefactoring rename: anOldName asClass to: aNewName) execute
]
