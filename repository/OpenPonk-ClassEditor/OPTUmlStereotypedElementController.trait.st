"
I am a trait for controllers managing UML elements that can have stereotypes applied. I provide form description methods and validation logic for manipulating stereotypes dynamically via Magritte.
"
Trait {
	#name : 'OPTUmlStereotypedElementController',
	#traits : 'OPTUmlBaseController',
	#classTraits : 'OPTUmlBaseController classTrait',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'stereotypes' }
OPTUmlStereotypedElementController >> applyStereotype: aStereotypeModel to: aModel [
	self
		deprecated: 'Use viewModel instead'
		transformWith: '`@receiver applyStereotype: `@arg1 to: `@arg2' -> '`@receiver viewModel applyStereotype: `@arg1 to: `@arg2'.
	^ self viewModel applyStereotype: aStereotypeModel to: aModel
]

{ #category : 'forms' }
OPTUmlStereotypedElementController >> descriptionStereotypeContent [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionStereotypeContent' -> '`@receiver viewModel descriptionStereotypeContent'.
	^ self viewModel descriptionStereotypeContent
]

{ #category : 'stereotypes' }
OPTUmlStereotypedElementController >> removeStereotypesIn: aModel [
	self
		deprecated: 'Use viewModel instead'
		transformWith: '`@receiver removeStereotypesIn: `@arg1' -> '`@receiver viewModel removeStereotypesIn: `@arg1'.
	^ self viewModel removeStereotypesIn: aModel
]

{ #category : 'stereotypes' }
OPTUmlStereotypedElementController >> stereotypesIn: aProfile for: aModel [
	self
		deprecated: 'Use viewModel instead'
		transformWith: '`@receiver stereotypesIn: `@arg1 for: `@arg2' -> '`@receiver viewModel stereotypesIn: `@arg1 for: `@arg2'.
	^ self viewModel stereotypesIn: aProfile for: aModel
]
