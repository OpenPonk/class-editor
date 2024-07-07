Class {
	#name : 'OPUmlClassifierController',
	#superclass : 'OPUmlElementController',
	#traits : 'OPTUmlPackageableController',
	#classTraits : 'OPTUmlPackageableController classTrait',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'figures' }
OPUmlClassifierController >> adornments [
	^ self subclassResponsibility
]

{ #category : 'adding' }
OPUmlClassifierController >> canBeSourceFor: aController [
	^ aController isKindOf: OPUmlAssociationController
]

{ #category : 'figures' }
OPUmlClassifierController >> createAdornmentsBy: builder [

	"do nothing by default"
]

{ #category : 'construction' }
OPUmlClassifierController >> createModelIn: aParentModel [

	^ (super createModelIn: aParentModel)
		  name: self modelClassName;
		  yourself
]

{ #category : 'accessing' }
OPUmlClassifierController >> dependentElements [

	| innerElements associations |
	innerElements := self elementsToShowInside.
	associations := self
		                parentPackageDo: [ :parentPackage |
			                parentPackage packagedElements select: [ :eachAssoc |
				                (eachAssoc oclIsKindOf: #Association) and: [
					                eachAssoc memberEnds anySatisfy: [ :any |
						                any type = self model or: [
							                any owningClass = self model ] ] ] ] ]
		                ifNone: [ #(  ) ].
	^ innerElements , associations
]

{ #category : 'forms' }
OPUmlClassifierController >> descriptionName [

	<magritteDescription>
	| accessor |
	accessor := MAPluggableAccessor
		            read: [ :me | me model name ]
		            write: [ :me :newValue | 
			            me model name: newValue.
			            self diagramElement modelChanged ].
	^ MAMemoDescription new
		  accessor: accessor;
		  label: 'Name';
		  priority: 1;
		  yourself
]

{ #category : 'accessing' }
OPUmlClassifierController >> findPackagesIn: packagesList [

	| packagedElements |
	packagedElements := packagesList last packagedElements.
	(packagedElements identityIncludes: self model) ifTrue: [
		^ packagesList ].
	packagedElements
		select: [ :each | each oclIsKindOf: #Package ]
		thenDo: [ :each |
			(self findPackagesIn: (packagesList copyWith: each)) ifNotEmpty: [
				:foundList | ^ foundList ] ].
	^ #(  )
]

{ #category : 'construction' }
OPUmlClassifierController >> hookDiagramElement [

	super hookDiagramElement.

	self diagramElement adornmentCreationBlock: [ :builder |
		self createAdornmentsBy: builder ].
	self diagramElement hiddenPackages: self hiddenPackages
]

{ #category : 'testing' }
OPUmlClassifierController >> isHideable [
	^ true
]

{ #category : 'accessing' }
OPUmlClassifierController >> modelClassName [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
OPUmlClassifierController >> packageRenderChanged [

	(self diagramElement hiddenPackages: self hiddenPackages) ifFalse: [
		^ self ].
	self diagramElement isRendered ifFalse: [ ^ self ].
	self diagramElement updateRenderFromModel
]

{ #category : 'construction' }
OPUmlClassifierController >> registerModelInContainer: aParentModel [

	aParentModel packagedElements add: model
]

{ #category : 'event handling' }
OPUmlClassifierController >> updateAfterDiagramFocused [

	self diagramElement hiddenPackages: self hiddenPackages.
	super updateAfterDiagramFocused
]
