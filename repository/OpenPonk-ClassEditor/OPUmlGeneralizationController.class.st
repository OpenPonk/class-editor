"
I am a controller for UML Generalizations. I manage the domain relationship between specific and general classifiers and provide form descriptions for viewing and editing generalization sets.
"
Class {
	#name : 'OPUmlGeneralizationController',
	#superclass : 'OPUmlRelationshipController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPUmlGeneralizationController class >> diagramElementClass [

	^ OPUmlGeneralizationShape
]

{ #category : 'accessing' }
OPUmlGeneralizationController class >> viewModelClass [
	^ OPUmlGeneralizationViewModel
]

{ #category : 'construction' }
OPUmlGeneralizationController >> createModelIn: aParentModel [
	"Ensure generalization uses its specific classifier as container even when diagram model is passed."

	| containerModel |
	containerModel := (aParentModel respondsTo: #oclIsKindOf:)
		ifTrue: [
			(aParentModel oclIsKindOf: #Classifier)
				ifTrue: [ aParentModel ]
				ifFalse: [ self source ifNotNil: [ :activeSource | activeSource model ] ] ]
		ifFalse: [ self source ifNotNil: [ :activeSource | activeSource model ] ].
	^ super createModelIn: containerModel
]

{ #category : 'forms' }
OPUmlGeneralizationController >> descriptionGeneral [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionGeneral' -> '`@receiver viewModel descriptionGeneral'.
	^ self viewModel descriptionGeneral
]

{ #category : 'forms' }
OPUmlGeneralizationController >> descriptionGeneralizationSets [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionGeneralizationSets' -> '`@receiver viewModel descriptionGeneralizationSets'.
	^ self viewModel descriptionGeneralizationSets
]

{ #category : 'forms' }
OPUmlGeneralizationController >> descriptionSpecific [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionSpecific' -> '`@receiver viewModel descriptionSpecific'.
	^ self viewModel descriptionSpecific
]

{ #category : 'actions' }
OPUmlGeneralizationController >> maEdit [
	self viewModel
		openEditorWithApplication: self diagramController canvasPresenter application
		undoManager: self diagramController undoManager.
	self diagramController openInForm: self
]

{ #category : 'connecting' }
OPUmlGeneralizationController >> parentModelInTarget: aTargetController [
	"Generalization is structurally owned by its specific classifier (source)."

	^ self source
		  ifNotNil: [ :activeSource | activeSource model ]
		  ifNil: [ self model ifNotNil: [ :activeModel | activeModel specific ] ]
]
