"
I am the controller for UML Properties (Attributes). I manage UI form descriptions for type, multiplicity, uniqueness, and ordering, and handle diagram interactions when attributes are re-assigned or moved to associations.
"
Class {
	#name : 'OPUmlAttributeController',
	#superclass : 'OPUmlClassItemController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPUmlAttributeController class >> diagramElementClass [

	^ OPUmlAttributeLabel
]

{ #category : 'accessing' }
OPUmlAttributeController class >> viewModelClass [
	^ OPUmlClassPropertyViewModel
]

{ #category : 'adding' }
OPUmlAttributeController >> addDiagramElementToOwner [

	self intendedOwningDiagramElement addAttribute: self diagramElement
]

{ #category : 'announcements' }
OPUmlAttributeController >> associationChanged [

	super modelChanged
]

{ #category : 'construction' }
OPUmlAttributeController >> createDiagramElement [

	(self model name isNil or: [ self model name trim isEmpty ]) ifTrue: [
		self model name: self viewModel placeholderName ].
	^ super createDiagramElement
]

{ #category : 'forms' }
OPUmlAttributeController >> descriptionDefaultValue [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionDefaultValue' -> '`@receiver viewModel descriptionDefaultValue'.
	^ self viewModel descriptionDefaultValue
]

{ #category : 'forms' }
OPUmlAttributeController >> descriptionIsDerived [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionIsDerived' -> '`@receiver viewModel descriptionIsDerived'.
	^ self viewModel descriptionIsDerived
]

{ #category : 'forms' }
OPUmlAttributeController >> descriptionIsOrdered [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionIsOrdered' -> '`@receiver viewModel descriptionIsOrdered'.
	^ self viewModel descriptionIsOrdered
]

{ #category : 'forms' }
OPUmlAttributeController >> descriptionIsReadOnly [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionIsReadOnly' -> '`@receiver viewModel descriptionIsReadOnly'.
	^ self viewModel descriptionIsReadOnly
]

{ #category : 'forms' }
OPUmlAttributeController >> descriptionIsUnique [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionIsUnique' -> '`@receiver viewModel descriptionIsUnique'.
	^ self viewModel descriptionIsUnique
]

{ #category : 'forms' }
OPUmlAttributeController >> descriptionMultiplicity [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionMultiplicity' -> '`@receiver viewModel descriptionMultiplicity'.
	^ self viewModel descriptionMultiplicity
]

{ #category : 'forms' }
OPUmlAttributeController >> descriptionType [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionType' -> '`@receiver viewModel descriptionType'.
	^ self viewModel descriptionType
]

{ #category : 'announcements' }
OPUmlAttributeController >> modelChanged [

	super modelChanged.
	self model association ifNotNil: [ :association |
		self diagramController
			controllerForModel: association
			ifFound: [ :controller | controller classAttributeChanged ] ]
]

{ #category : 'destruction' }
OPUmlAttributeController >> removeDiagramElement [

	self diagramElement ifNotExists: [ ^ self ].
	self diagramElementOwnerWithPossibleController ifExists: [ :owner |
		owner removeAttribute: self diagramElement ].
	self diagramElement: nil
]

{ #category : 'removing' }
OPUmlAttributeController >> switchOwnerToAssociation [

	self model owningClass: nil.
	self model owningAssociation: self model association
]

{ #category : 'deprecation' }
OPUmlAttributeController >> typeNamed: aName [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver typeNamed: `@arg1' -> '`@receiver viewModel typeNamed: `@arg1'.
	^ self viewModel typeNamed: aName
]

{ #category : 'parsing' }
OPUmlAttributeController >> writeMultiplicityFrom: aString to: aProperty [
	self
		deprecated: 'Use viewModel instead'
		transformWith: '`@receiver writeMultiplicityFrom: `@arg1 to: `@arg2' -> '`@receiver viewModel writeMultiplicityFrom: `@arg1 to: `@arg2'.
	^ self viewModel writeMultiplicityFrom: aString to: aProperty
]
