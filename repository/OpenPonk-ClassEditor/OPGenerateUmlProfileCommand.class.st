Class {
	#name : 'OPGenerateUmlProfileCommand',
	#superclass : 'OPProjectTreeCommand',
	#category : 'OpenPonk-ClassEditor-Commands-ProjectTree',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands-ProjectTree'
}

{ #category : 'as yet unclassified' }
OPGenerateUmlProfileCommand >> canBeExecuted [
	self selectedViewModel ifNil: [ ^ false ].
	^ self selectedViewModel isKindOf: OPUmlProfileViewModel
]

{ #category : 'as yet unclassified' }
OPGenerateUmlProfileCommand >> execute [
	OPUmlProfileGeneratorWizard openOn: self selectedViewModel model
]

{ #category : 'as yet unclassified' }
OPGenerateUmlProfileCommand >> initialize [
	super initialize.
	self name: 'Generate Profile...'
]
