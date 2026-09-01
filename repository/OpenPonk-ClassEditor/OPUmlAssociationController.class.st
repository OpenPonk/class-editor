"
I am the controller for UML Associations. I manage form descriptions for source and target ends, multiplicity, navigability, and provide functionality to explicitly swap the source and target direction.
"
Class {
	#name : 'OPUmlAssociationController',
	#superclass : 'OPUmlAbstractAssociationController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPUmlAssociationController class >> diagramElementClass [

	^ OPUmlAssociationShape
]

{ #category : 'accessing' }
OPUmlAssociationController class >> viewModelClass [
	^ OPUmlAssociationViewModel
]

{ #category : 'deprecation' }
OPUmlAssociationController >> descriptionActionSwitchSourceTarget [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionActionSwitchSourceTarget' -> '`@receiver viewModel descriptionActionSwitchSourceTarget'.
	^ self viewModel descriptionActionSwitchSourceTarget
]

{ #category : 'forms' }
OPUmlAssociationController >> descriptionIsDerived [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionIsDerived' -> '`@receiver viewModel descriptionIsDerived'.
	^ self viewModel descriptionIsDerived
]

{ #category : 'forms' }
OPUmlAssociationController >> descriptionSeparator [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionSeparator' -> '`@receiver viewModel descriptionSeparator'.
	^ self viewModel descriptionSeparator
]

{ #category : 'forms' }
OPUmlAssociationController >> descriptionSourceEnd [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionSourceEnd' -> '`@receiver viewModel descriptionSourceEnd'.
	^ self viewModel descriptionSourceEnd
]

{ #category : 'forms' }
OPUmlAssociationController >> descriptionStereotype [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionStereotype' -> '`@receiver viewModel descriptionStereotype'.
	^ self viewModel descriptionStereotype
]

{ #category : 'forms' }
OPUmlAssociationController >> descriptionTargetEnd [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionTargetEnd' -> '`@receiver viewModel descriptionTargetEnd'.
	^ self viewModel descriptionTargetEnd
]

{ #category : 'actions' }
OPUmlAssociationController >> endsSwapped [
	source := self diagramController controllerForModel: self model memberEnds second type.
	self diagramElement switchSourceAndTarget
]

{ #category : 'announcements' }
OPUmlAssociationController >> subscribeToViewModel [

	super subscribeToViewModel.
	self viewModel announcer weak
		when: OPAssociationEndsSwapped
		send: #endsSwapped
		to: self
]

{ #category : 'deprecation' }
OPUmlAssociationController >> switchSourceAndTarget [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver switchSourceAndTarget' -> '`@receiver viewModel switchSourceAndTarget'.
	^ self viewModel switchSourceAndTarget
]

{ #category : 'parsing' }
OPUmlAssociationController >> writeMultiplicityFrom: aString to: aProperty [
	self
		deprecated: 'Use viewModel instead'
		transformWith: '`@receiver writeMultiplicityFrom: `@arg1 to: `@arg2' -> '`@receiver viewModel writeMultiplicityFrom: `@arg1 to: `@arg2'.
	^ self viewModel writeMultiplicityFrom: aString to: aProperty
]

{ #category : 'parsing' }
OPUmlAssociationController >> writeNavigability: isNavigable to: aProperty [

	self
		deprecated:
		'Use viewModel for domain logic and handle UI updates manually.'
		transformWith: '`@receiver writeNavigability: `@arg1 to: `@arg2'
			-> '`@receiver viewModel writeNavigability: `@arg1 to: `@arg2'.

	^ self viewModel writeNavigability: isNavigable to: aProperty
]
