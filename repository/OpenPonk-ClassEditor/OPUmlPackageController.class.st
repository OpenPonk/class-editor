"
I am the controller for UML Packages, Models, and Profiles. I manage nested elements, generalization sets, visibility configurations, and canvas rendering for package-like elements.
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

{ #category : 'construction' }
OPUmlPackageController class >> diagramElementClass [

	^ OPUmlPackageShape
]

{ #category : 'accessing' }
OPUmlPackageController class >> viewModelClass [
	^ OPUmlPackageViewModel
]

{ #category : 'configuration' }
OPUmlPackageController >> beForModel [

	self
		deprecated: 'Use beForPackage instead'
		transformWith: '`@receiver beForModel' -> '`@receiver beForPackage'.
	^ self beForPackage
]

{ #category : 'configuration' }
OPUmlPackageController >> beForPackage [
	modelClass := OPUMLPackage
]

{ #category : 'configuration' }
OPUmlPackageController >> beForProfile [
	modelClass := OPUMLProfile
]

{ #category : 'connecting' }
OPUmlPackageController >> canBeSourceFor: aController [
	^ aController isKindOf: OPUmlPackageImportController
]

{ #category : 'connecting' }
OPUmlPackageController >> canBeTargetFor: aController [

	^ (aController isKindOf: OPUmlPackageImportController) or: [ 
		  (aController isKindOf: OPUmlClassController) or: [ 
			  (aController isKindOf: OPUmlPackageController) or: [ 
				  aController isKindOf: OPUmlEnumerationController ] ] ]
]

{ #category : 'construction' }
OPUmlPackageController >> hookDiagramElement [

	super hookDiagramElement.

	self diagramElement innerRoassalShapesBlock: [
		Array streamContents: [ :stream |
			self diagramController
				propagateBlock: [ :eachController |
					eachController roassalShape ifNotNil: [ :roassalShape |
						stream nextPut: roassalShape ] ]
				toNodeControllersIn: self model ] ].
	self diagramElement hiddenPackages: self hiddenPackages
]

{ #category : 'updating' }
OPUmlPackageController >> packageRenderChanged [

	self diagramElement ifExists: [ :foundDE |
		(foundDE hiddenPackages: self hiddenPackages) ifTrue: [
			foundDE isRendered ifTrue: [ foundDE updateRenderFromModel ] ] ].
	self diagramController propagatePackageRenderChangedIn: self model
]

{ #category : 'actions' }
OPUmlPackageController >> pushBack [

	self diagramElement pushBack.
	self closestRenderedParentPackageControllerDo: [ :packageController |
		^ packageController pushBack ]
]

{ #category : 'destruction' }
OPUmlPackageController >> removeDiagramElement [

	self diagramElement ifNotExists: [ ^ self ].
	super removeDiagramElement.
	self packageRenderChanged
]

{ #category : 'construction' }
OPUmlPackageController >> renderDiagramElement [

	super renderDiagramElement.
	self packageRenderChanged.
	self pushBack
]

{ #category : 'diagram elements' }
OPUmlPackageController >> unhookDiagramElement [

	super unhookDiagramElement.

	(self diagramElement ifNotExists: [ ^ self ])
		innerRoassalShapesBlock: [ Array empty ]
]

{ #category : 'event handling' }
OPUmlPackageController >> updateAfterDiagramFocused [

	self diagramElement hiddenPackages: self hiddenPackages.
	super updateAfterDiagramFocused
]
