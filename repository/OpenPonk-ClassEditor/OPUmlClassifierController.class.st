Class {
	#name : 'OPUmlClassifierController',
	#superclass : 'OPUmlElementController',
	#instVars : [
		'packages'
	],
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
	associations := diagramController model packagedElements select: [
		                :eachAssoc |
		                (eachAssoc oclIsKindOf: #Association) and: [
			                eachAssoc memberEnds anySatisfy: [ :any |
				                any type = self model or: [
					                any owningClass = self model ] ] ] ].

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
OPUmlClassifierController >> findPackagesIn: aPackageLinkedList [

	| packagedElements |
	packagedElements := aPackageLinkedList last packagedElements.
	(packagedElements identityIncludes: model) ifTrue: [
		^ aPackageLinkedList ].
	packagedElements
		select: [ :each | each oclIsKindOf: #Package ]
		thenDo: [ :each |
			(self findPackagesIn: (aPackageLinkedList copyWith: each))
				ifNotEmpty: [ :foundList | ^ foundList ] ].
	^ LinkedList empty
]

{ #category : 'accessing' }
OPUmlClassifierController >> hiddenPackages [

	| hiddenPackages |
	hiddenPackages := LinkedList new.
	self packages reverseDo: [ :each |
		self diagramController
			controllerForModel: each
			ifFound: [ :ctrl | ctrl isRendered ifTrue: [ ^ hiddenPackages ] ].
		hiddenPackages addFirst: each ].
	^ hiddenPackages
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

	self diagramElement hiddenPackages: self hiddenPackages.
	self diagramElement isRendered ifFalse: [ ^ self ].
	self diagramElement updateRenderFromModel
]

{ #category : 'accessing' }
OPUmlClassifierController >> packages [

	^ packages ifNil: [
		  packages := self findPackagesIn:
			             (Stack with: diagramController model) ]
]

{ #category : 'construction' }
OPUmlClassifierController >> registerModelInContainer: aParentModel [

	aParentModel packagedElements add: model
]

{ #category : 'removing' }
OPUmlClassifierController >> removeModel [
	diagramController model packagedElements remove: self model
]
