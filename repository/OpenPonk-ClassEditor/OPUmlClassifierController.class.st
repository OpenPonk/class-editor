Class {
	#name : 'OPUmlClassifierController',
	#superclass : 'OPUmlElementController',
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

{ #category : 'figures' }
OPUmlClassifierController >> hookDiagramElement [

	super hookDiagramElement.
	
	self diagramElement adornmentCreationBlock: [ :builder | 
		self createAdornmentsBy: builder ]
]

{ #category : 'testing' }
OPUmlClassifierController >> isHideable [
	^ true
]

{ #category : 'accessing' }
OPUmlClassifierController >> modelClassName [
	^ self subclassResponsibility
]

{ #category : 'construction' }
OPUmlClassifierController >> registerModelInContainer: aParentModel [

	aParentModel packagedElements add: model
]

{ #category : 'removing' }
OPUmlClassifierController >> removeModel [
	diagramController model packagedElements remove: self model
]
