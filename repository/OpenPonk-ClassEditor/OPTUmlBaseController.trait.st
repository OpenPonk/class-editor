"
I am a foundational trait for UML element controllers. I provide common validation hooks and descriptive Magritte accessors for properties like name, visibility, and comments.
"
Trait {
	#name : 'OPTUmlBaseController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'forms' }
OPTUmlBaseController >> descriptionAccessor: aSymbol [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionAccessor: `@arg1' -> '`@receiver viewModel descriptionAccessor: `@arg1'.
	^ self viewModel descriptionAccessor: aSymbol
]

{ #category : 'forms' }
OPTUmlBaseController >> descriptionComment [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionComment' -> '`@receiver viewModel descriptionComment'.
	^ self viewModel descriptionComment
]

{ #category : 'forms' }
OPTUmlBaseController >> descriptionModelInfo [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionModelInfo' -> '`@receiver viewModel descriptionModelInfo'.
	^ self viewModel descriptionModelInfo
]

{ #category : 'forms' }
OPTUmlBaseController >> descriptionName [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionName' -> '`@receiver viewModel descriptionName'.
	^ self viewModel descriptionName
]

{ #category : 'forms' }
OPTUmlBaseController >> descriptionVisibility [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionVisibility' -> '`@receiver viewModel descriptionVisibility'.
	^ self viewModel descriptionVisibility
]

{ #category : 'validation' }
OPTUmlBaseController >> validateProperty: aProperty [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver validateProperty: `@arg1' -> '`@receiver viewModel validateProperty: `@arg1'.
	^ self viewModel validateProperty: aProperty
]

{ #category : 'validation' }
OPTUmlBaseController >> validationFailedAssociationPropertyWithoutClassifierType: arg1 [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver validationFailedAssociationPropertyWithoutClassifierType: `@arg1' -> '`@receiver viewModel validationFailedAssociationPropertyWithoutClassifierType: `@arg1'.
	^ self viewModel validationFailedAssociationPropertyWithoutClassifierType: arg1
]

{ #category : 'validation' }
OPTUmlBaseController >> validationFailedPropertyWithTwoOwners: arg1 [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver validationFailedPropertyWithTwoOwners: `@arg1' -> '`@receiver viewModel validationFailedPropertyWithTwoOwners: `@arg1'.
	^ self viewModel validationFailedPropertyWithTwoOwners: arg1
]

{ #category : 'validation' }
OPTUmlBaseController >> validationFailedPropertyWithoutOwner: arg1 [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver validationFailedPropertyWithoutOwner: `@arg1' -> '`@receiver viewModel validationFailedPropertyWithoutOwner: `@arg1'.
	^ self viewModel validationFailedPropertyWithoutOwner: arg1
]
