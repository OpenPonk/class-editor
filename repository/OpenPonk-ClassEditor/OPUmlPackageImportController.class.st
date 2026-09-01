"
I am a controller for UML PackageImports. I manage the directed relationship where an importing namespace gains visibility into an imported package.
"
Class {
	#name : 'OPUmlPackageImportController',
	#superclass : 'OPUmlRelationshipController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPUmlPackageImportController class >> diagramElementClass [

	^ OPUmlPackageImportShape
]

{ #category : 'accessing' }
OPUmlPackageImportController class >> viewModelClass [
	^ OPUmlPackageImportViewModel
]

{ #category : 'forms' }
OPUmlPackageImportController >> descriptionGeneral [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionGeneral' -> '`@receiver viewModel descriptionGeneral'.
	^ self viewModel descriptionGeneral
]

{ #category : 'forms' }
OPUmlPackageImportController >> descriptionSpecific [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionSpecific' -> '`@receiver viewModel descriptionSpecific'.
	^ self viewModel descriptionSpecific
]
