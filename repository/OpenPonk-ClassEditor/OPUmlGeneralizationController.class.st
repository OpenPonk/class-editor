"
I am a controller for UML Generalization.
"
Class {
	#name : #OPUmlGeneralizationController,
	#superclass : #OPUmlRelationshipController,
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #figures }
OPUmlGeneralizationController >> createModelIn: aParentModel [
	self model: self modelClass new.
	model general: aParentModel.
	model specific: source model.
	^ model
]

{ #category : #forms }
OPUmlGeneralizationController >> descriptionGeneral [
	<magritteDescription>
	^ MAStringDescription new
		beReadOnly;
		accessor:
			(MAPluggableAccessor read: [ :me | me model general name ] write: [ :me :newValue |  ]);
		label: 'General';
		priority: 1;
		yourself
]

{ #category : #forms }
OPUmlGeneralizationController >> descriptionGeneralizationSet [

	<magritteDescription>
	^ MAToManyRelationDescription new
		  initializer: [ :desc | desc initializeFor: self ];
		  display: [ :desc | 
			  String streamContents: [ :stream | 
					  stream << (desc set name ifNil: [ 'unnamed' ]) << ': '
					  << (desc set isCovering
							   ifTrue: [ 'complete' ]
							   ifFalse: [ 'incomplete' ]) << ', ' << (desc set isDisjoint
							   ifTrue: [ 'disjoint' ]
							   ifFalse: [ 'overlapping' ]) << ' ('
					  << (desc set generalizations size pluralize: 'generalization')
					  << ')' ] ];
		  accessor: (MAPluggableAccessor
				   read: [ :me | 
					   me model generalizationSets collect: [ :each | 
							   OPUmlGeneralizationSetDescriptions new
								   controller: self;
								   set: each ] ]
				   write: [ :me :newValue | 
					   | oldSets newSets setsToRemove setsToAdd |
					   oldSets := me model generalizationSets asArray.
					   newSets := newValue collect: #set.
					   oldSets do: [ :each | each generalizations remove: me model ].
					   newSets do: [ :each | each generalizations add: me model ].
					   setsToRemove := oldSets select: [ :each | 
						                   each generalizations isEmpty ].
					   setsToAdd := newSets select: [ :each | 
						                each generalizations size = 1 ].
					   me model generalizationSets: newSets.
					   diagramController model packagedElements:
						   diagramController model packagedElements \ setsToRemove
						   , setsToAdd.
					   diagramElement ifNotNil: [ 
						   self diagramElement updateRenderFromModel ] ]);
		  classes: { OPUmlGeneralizationSetDescriptions };
		  label: 'Generalization Sets';
		  priority: 5;
		  yourself
]

{ #category : #forms }
OPUmlGeneralizationController >> descriptionName [
	^ nil
]

{ #category : #forms }
OPUmlGeneralizationController >> descriptionSpecific [
	<magritteDescription>
	^ MAStringDescription new
		beReadOnly;
		accessor:
			(MAPluggableAccessor read: [ :me | me model specific name ] write: [ :me :newValue |  ]);
		label: 'Specific';
		priority: 2;
		yourself
]

{ #category : #forms }
OPUmlGeneralizationController >> descriptionVisibility [
	^ nil
]

{ #category : #figures }
OPUmlGeneralizationController >> diagramElementClass [

	^ OPUmlGeneralizationShape
]

{ #category : #accessing }
OPUmlGeneralizationController >> modelClass [
	^ OPUMLGeneralization
]

{ #category : #forms }
OPUmlGeneralizationController >> modelSource [
	^ model general
]

{ #category : #forms }
OPUmlGeneralizationController >> modelTarget [
	^ model specific
]

{ #category : #removing }
OPUmlGeneralizationController >> removeModel [
	model general: nil.
	model specific: nil.
	model generalizationSets asArray
		do: [ :each | 
			each generalizations remove: model.
			each generalizations
				ifEmpty: [ diagramController model packagedElements
						remove: each
						ifAbsent: [ "do nothing" ] ] ]
]

{ #category : #construction }
OPUmlGeneralizationController >> showWithoutDependentInDiagram: aDiagramController [
	aDiagramController showWithoutDependentInDiagramModel: model general.
	aDiagramController showWithoutDependentInDiagramModel: model specific.
	^ super showWithoutDependentInDiagram: aDiagramController
]
