"
I am a controller for Package/Model/Profile
"
Class {
	#name : 'OPUmlPackageController',
	#superclass : 'OPUmlElementController',
	#traits : 'OPTUmlPackageableController',
	#classTraits : 'OPTUmlPackageableController classTrait',
	#instVars : [
		'modelClass'
	],
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'configuration' }
OPUmlPackageController >> beForModel [
	modelClass := OPUMLPackage
]

{ #category : 'configuration' }
OPUmlPackageController >> beForPackage [
	modelClass := OPUMLPackage
]

{ #category : 'configuration' }
OPUmlPackageController >> beForProfile [
	modelClass := OPUMLProfile
]

{ #category : 'testing' }
OPUmlPackageController >> canBeSourceFor: aController [
	^ aController isKindOf: OPUmlPackageImportController
]

{ #category : 'testing' }
OPUmlPackageController >> canBeTargetFor: aController [

	^ (aController isKindOf: OPUmlPackageImportController) or: [ 
		  (aController isKindOf: OPUmlClassController) or: [ 
			  (aController isKindOf: OPUmlPackageController) or: [ 
				  aController isKindOf: OPUmlEnumerationController ] ] ]
]

{ #category : 'construction' }
OPUmlPackageController >> createModelIn: aParentModel [

	super createModelIn: aParentModel.
	model name: (model oclClassifierNameFrom: model class).
	^ model
]

{ #category : 'accessing' }
OPUmlPackageController >> dependentElements [

	| mainTypes imports importsOfMe |
	mainTypes := (self model packagedElements select: [ :each |
		              { #Class. #Package. #Enumeration } anySatisfy: [ :any |
			              each oclIsKindOf: any ] ]) asSet.
	imports := self model packageImports.

	importsOfMe := self
		               parentPackageDo: [ :parentPackage |
			               (parentPackage packagedElements select: [ :each |
				                each oclIsKindOf: #Package ]) flatCollectAsSet: [
				               :eachPackagedElement |
				               eachPackagedElement packageImports select: [
					               :eachImport |
					               eachImport importingNamespace = self model ] ] ]
		               ifNone: [ #(  ) ].
	^ mainTypes , imports , importsOfMe
]

{ #category : 'figures' }
OPUmlPackageController >> diagramElementClass [

	^ OPUmlPackageShape
]

{ #category : 'construction' }
OPUmlPackageController >> hookDiagramElement [

	super hookDiagramElement.

	diagramElement innerRoassalShapesBlock: [
		Array streamContents: [ :stream |
			self diagramController
				propagateBlock: [ :eachController |
					eachController roassalShape ifNotNil: [ :roassalShape |
						stream nextPut: roassalShape ] ]
				toNodeControllersIn: self model ] ].
	self diagramElement hiddenPackages: self hiddenPackages
]

{ #category : 'testing' }
OPUmlPackageController >> isHideable [
	^ true
]

{ #category : 'accessing' }
OPUmlPackageController >> modelClass [
	modelClass ifNil: [ self beForPackage ].
	^ modelClass
]

{ #category : 'updating' }
OPUmlPackageController >> packageRenderChanged [

	self diagramElement ifNotNil: [ :foundDE |
		(foundDE hiddenPackages: self hiddenPackages) ifTrue: [
			foundDE isRendered ifTrue: [ foundDE updateRenderFromModel ] ] ].
	self diagramController propagatePackageRenderChangedIn: self model
]

{ #category : 'actions' }
OPUmlPackageController >> pushBack [

	self diagramElement pushBack.
	self closestRenderedPackageControllerDo: [ :packageController |
		^ packageController pushBack ]
]

{ #category : 'construction' }
OPUmlPackageController >> registerModelInContainer: aParentModel [

	aParentModel packagedElements add: model
]

{ #category : 'destruction' }
OPUmlPackageController >> removeDiagramElement [

	self diagramElement ifNil: [ ^ self ].
	super removeDiagramElement.
	self packageRenderChanged
]

{ #category : 'construction' }
OPUmlPackageController >> renderDiagramElement [

	super renderDiagramElement.
	self packageRenderChanged.
	self pushBack
]

{ #category : 'event handling' }
OPUmlPackageController >> updateAfterDiagramFocused [

	self diagramElement hiddenPackages: self hiddenPackages.
	super updateAfterDiagramFocused
]
