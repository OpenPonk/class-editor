"
A project tree command that compiles and generates an active UML profile from the selected package definition.
"
Class {
	#name : 'OPGenerateUmlProfileCommand',
	#superclass : 'OPProjectTreeCommand',
	#category : 'OpenPonk-ClassEditor-Commands-ProjectTree',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands-ProjectTree'
}

{ #category : 'testing' }
OPGenerateUmlProfileCommand >> canBeExecuted [
	self selectedViewModel ifNil: [ ^ false ].
	^ self selectedViewModel isKindOf: OPUmlProfileViewModel
]

{ #category : 'executing' }
OPGenerateUmlProfileCommand >> execute [
	OPUmlProfileGeneratorWizard openOn: self selectedViewModel model
]

{ #category : 'accessing' }
OPGenerateUmlProfileCommand >> iconName [
	"Answer the icon name for launching the UML profile generation wizard."
	^ #smallConfiguration
]

{ #category : 'initialization' }
OPGenerateUmlProfileCommand >> initialize [
	super initialize.
	self name: 'Generate Profile...'
]
