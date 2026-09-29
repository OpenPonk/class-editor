"
I am the ViewModel for UML Generalizations, managing the relationship between a specific classifier and a more general classifier.
"
Class {
	#name : 'OPUmlGeneralizationViewModel',
	#superclass : 'OPUmlElementViewModel',
	#category : 'OpenPonk-ClassEditor-ViewModels',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPUmlGeneralizationViewModel class >> modelClass [ ^ OPUMLGeneralization
]

{ #category : 'construction' }
OPUmlGeneralizationViewModel >> attachModelFrom: sourceViewModel to: targetViewModel [

	self model specific: sourceViewModel model.
	self model general: targetViewModel model
]

{ #category : 'private' }
OPUmlGeneralizationViewModel >> basicRemoveModel [
	| targetPackageModel specificClassifier |
	targetPackageModel := self parentPackageViewModel ifNotNil: #model.
	specificClassifier := self model specific.

	self model generalizationSets do: [ :eachSet |
		eachSet generalizations remove: self model ifAbsent: [  ].
		eachSet generalizations ifEmpty: [
			targetPackageModel ifNotNil: [ :pkgModel |
				pkgModel packagedElements remove: eachSet ifAbsent: [  ] ] ] ].

	specificClassifier ifNotNil: [ :spec |
		spec generalizations remove: self model ifAbsent: [  ] ].

	self model general: nil.
	self model specific: nil
]

{ #category : 'construction' }
OPUmlGeneralizationViewModel >> createModelFrom: sourceViewModel to: targetViewModel in: aParentModel [
	"A generalization is structurally owned by its specific classifier (source)."

	self model: self modelClass new.
	self attachModelFrom: sourceViewModel to: targetViewModel.
	self registerModelIn: sourceViewModel model.
	^ self model
]

{ #category : 'accessing' }
OPUmlGeneralizationViewModel >> creationPriority [
	"Edges must be created and rendered after connected nodes."
	^ 20
]

{ #category : 'accessing' }
OPUmlGeneralizationViewModel >> dependingOnElements [

	^ super dependingOnElements , {
		  self model general.
		  self model specific }
]

{ #category : 'forms' }
OPUmlGeneralizationViewModel >> descriptionGeneral [
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
OPUmlGeneralizationViewModel >> descriptionGeneralizationSets [

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
OPUmlGeneralizationViewModel >> descriptionName [
	^ nil
]

{ #category : 'forms' }
OPUmlGeneralizationViewModel >> descriptionSpecific [
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
OPUmlGeneralizationViewModel >> descriptionVisibility [
	^ nil
]

{ #category : 'accessing' }
OPUmlGeneralizationViewModel >> findParentViewModel [

	^ (self registry viewModelFor: self model specific) packageViewModel
]

{ #category : 'accessing' }
OPUmlGeneralizationViewModel >> icon [ ^ OPUmlIcons generalizationIcon
]

{ #category : 'printing' }
OPUmlGeneralizationViewModel >> modelDisplayStringOn: aStream [
    aStream nextPutAll: (self model specific ifNotNil: #name ifNil: ['?']).
    aStream nextPutAll: ' => '.
    aStream nextPutAll: (self model general ifNotNil: #name ifNil: ['?']).
    aStream space; nextPutAll: '(Generalization)'
]

{ #category : 'accessing' }
OPUmlGeneralizationViewModel >> modelSource [
	"Answer the source model element (specific classifier) of this generalization."

	^ self model ifNotNil: [ :activeModel | activeModel specific ]
]

{ #category : 'accessing' }
OPUmlGeneralizationViewModel >> modelTarget [
	"Answer the target model element (general classifier) of this generalization."

	^ self model ifNotNil: [ :activeModel | activeModel general ]
]

{ #category : 'actions' }
OPUmlGeneralizationViewModel >> openEditorWithApplication: anApplication undoManager: anUndoManager [
	| editor |
	editor := OPUmlGeneralizationEditor new.
	anApplication ifNotNil: [ :app | editor application: app ].
	anUndoManager ifNotNil: [ :mgr | editor undoManager: mgr ].
	editor viewModel: self.
	editor openModal.
	self modelChanged
]

{ #category : 'accessing' }
OPUmlGeneralizationViewModel >> parentContainerModel [
	"Generalization is structurally owned by its specific classifier."

	^ self model specific
]

{ #category : 'registration' }
OPUmlGeneralizationViewModel >> registerModelIn: aParentModel [
	"Restore the generalization into its owning classifier container."

	self
		assert: ((aParentModel respondsTo: #oclIsKindOf:) and: [ aParentModel oclIsKindOf: #Classifier ])
		description: 'Generalization must be contained in a classifier'.

	self model specific: aParentModel.
	aParentModel generalizations addIfNotPresent: self model
]
