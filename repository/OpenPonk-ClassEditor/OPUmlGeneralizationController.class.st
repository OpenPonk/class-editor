"
I am a controller for UML Generalization.
"
Class {
	#name : 'OPUmlGeneralizationController',
	#superclass : 'OPUmlRelationshipController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'forms' }
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

{ #category : 'forms' }
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
					   self parentPackageDo: [ :parentPackage |
						   parentPackage packagedElements:
							   parentPackage packagedElements \ setsToRemove , setsToAdd ].
					   self diagramElement modelChanged ]);
		  classes: { OPUmlGeneralizationSetDescriptions };
		  label: 'Generalization Sets';
		  priority: 5;
		  yourself
]

{ #category : 'forms' }
OPUmlGeneralizationController >> descriptionName [
	^ nil
]

{ #category : 'forms' }
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

{ #category : 'forms' }
OPUmlGeneralizationController >> descriptionVisibility [
	^ nil
]

{ #category : 'figures' }
OPUmlGeneralizationController >> diagramElementClass [

	^ OPUmlGeneralizationShape
]

{ #category : 'accessing' }
OPUmlGeneralizationController >> modelClass [
	^ OPUMLGeneralization
]

{ #category : 'forms' }
OPUmlGeneralizationController >> modelSource [

	^ self model specific
]

{ #category : 'figures' }
OPUmlGeneralizationController >> modelSource: aModel in: aParentModel [
	"answers whether model's source has been changed"

	self modelSource = aModel ifTrue: [ ^ false ].
	self model specific: aModel.
	^ true
]

{ #category : 'forms' }
OPUmlGeneralizationController >> modelTarget [

	^ self model general
]

{ #category : 'figures' }
OPUmlGeneralizationController >> modelTarget: aModel in: aParentModel [
	"answers whether model's target has been changed"

	self modelTarget = aModel ifTrue: [ ^ false ].
	self model general: aModel.
	^ true
]

{ #category : 'accessing' }
OPUmlGeneralizationController >> packagedModel [

	^ self model specific
]

{ #category : 'construction' }
OPUmlGeneralizationController >> registerModelInContainer: aParentModel [

	"do nothing"
]

{ #category : 'removing' }
OPUmlGeneralizationController >> removeModel [

	self model general: nil.
	self model specific: nil.
	self model generalizationSets asArray do: [ :each |
		each generalizations remove: self model.
		each generalizations ifEmpty: [
			self parentPackageDo: [ :parentPackage |
				parentPackage packagedElements
					remove: each
					ifAbsent: [ "do nothing" ] ] ] ].
	super removeModel
]
