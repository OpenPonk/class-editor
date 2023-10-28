"
I am a controller for Package/Model/Profile
"
Class {
	#name : #OPUmlPackageController,
	#superclass : #OPUmlElementController,
	#instVars : [
		'modelClass'
	],
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #configuration }
OPUmlPackageController >> beForModel [
	modelClass := OPUMLPackage
]

{ #category : #configuration }
OPUmlPackageController >> beForPackage [
	modelClass := OPUMLPackage
]

{ #category : #configuration }
OPUmlPackageController >> beForProfile [
	modelClass := OPUMLProfile
]

{ #category : #testing }
OPUmlPackageController >> canBeSourceFor: aController [
	^ aController isKindOf: OPUmlPackageImportController
]

{ #category : #testing }
OPUmlPackageController >> canBeTargetFor: aController [

	^ (aController isKindOf: OPUmlPackageImportController) or: [ 
		  (aController isKindOf: OPUmlClassController) or: [ 
			  (aController isKindOf: OPUmlPackageController) or: [ 
				  aController isKindOf: OPUmlEnumerationController ] ] ]
]

{ #category : #construction }
OPUmlPackageController >> createModelIn: aParentModel [
	| newModel names |
	newModel := self modelClass new.
	names := {(OPUMLPackage -> 'Package').
	(OPUMLProfile -> 'Profile')} asDictionary.
	newModel name: (names at: newModel class).
	self model: newModel.
	aParentModel packagedElements add: model.
	^ model
]

{ #category : #accessing }
OPUmlPackageController >> dependentElements [
	| mainElementTypes |
	mainElementTypes := {#Class . #Package . #Enumeration . #Profile.
	#Model}.
	^ (self model packagedElements
		select:
			[ :each | mainElementTypes anySatisfy: [ :any | each oclIsKindOf: any ] ])
		asSet , self model packageImports
		,
			((diagramController model packagedElements
				select: [ :each | 
					{#Package . #Profile . #Model}
						anySatisfy: [ :any | each oclIsKindOf: any ] ])
				flatCollectAsSet: [ :eachPackagedElement | 
					eachPackagedElement packageImports
						select: [ :eachImport | eachImport importingNamespace = self model ] ])
]

{ #category : #figures }
OPUmlPackageController >> diagramElementClass [

	^ OPUmlPackageShape
]

{ #category : #figures }
OPUmlPackageController >> hookDiagramElement [

	super hookDiagramElement.

	diagramElement innerRoassalShapesBlock: [ 
		self model packagedElements
			collect: [ :eachModel | 
				self diagramController
					controllerForModel: eachModel
					ifFound: #roassalShape ]
			thenSelect: #isNotNil ]
]

{ #category : #testing }
OPUmlPackageController >> isHideable [
	^ true
]

{ #category : #accessing }
OPUmlPackageController >> modelClass [
	modelClass ifNil: [ self beForPackage ].
	^ modelClass
]

{ #category : #removing }
OPUmlPackageController >> removeModel [
	diagramController model packagedElements remove: self model
]
