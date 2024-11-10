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
OPUmlGeneralizationController >> descriptionGeneralizationSets [

	<magritteDescription>
	^ MAToManyRelationDescription new
		  display: [ :set |
			  String streamContents: [ :stream |
					  stream << ' - '
					  << ((set name isNil or: [ set name trim isEmpty ])
							   ifTrue: [ 'generalization set' ]
							   ifFalse: [ set name ]) << ' ('
					  << (set generalizations size pluralize: 'generalization')
					  << ')' ] ];
		  accessor: (MAPluggableAccessor
				   read: [ :me | me model generalizationSets ]
				   write: [ :me :newValue |
					   self error:
							   'Direct manipulation only via '
							   , OPUmlGeneralizationEditor name ]);
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

{ #category : 'as yet unclassified' }
OPUmlGeneralizationController >> maEdit [

	| editor |
	editor := OPUmlGeneralizationEditor new.
	editor
		application: self diagramController editor application;
		controller: self;
		openModal.
	self diagramController openInForm: self
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
