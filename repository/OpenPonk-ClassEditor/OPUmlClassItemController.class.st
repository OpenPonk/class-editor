"
I am the base controller for items owned by a UML Class (such as attributes and operations). I handle UI properties like the `isStatic` modifier description.
"
Class {
	#name : 'OPUmlClassItemController',
	#superclass : 'OPUmlClassifierItemController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'deprecation' }
OPUmlClassItemController >> descriptionIsStatic [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionIsStatic' -> '`@receiver viewModel descriptionIsStatic'.
	^ self viewModel descriptionIsStatic
]
