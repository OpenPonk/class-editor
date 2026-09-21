"
I am a specialized Spec presenter extending OPUmlGeneralizationSetsEditor. I am scoped to a specific UML Generalization controller, allowing the user to add, remove, and manage the generalization sets specifically associated with that single generalization.
"
Class {
	#name : 'OPUmlGeneralizationSetsOfControllerEditor',
	#superclass : 'OPUmlGeneralizationSetsEditor',
	#instVars : [
		'infoLabel',
		'addGeneralizationSetButton',
		'partOfSets'
	],
	#category : 'OpenPonk-ClassEditor-UI',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'UI'
}

{ #category : 'private - actions' }
OPUmlGeneralizationSetsOfControllerEditor >> addNewSet [

	| newSet |
	newSet := OPUMLGeneralizationSet new.
	newSet uuid.
	self addToSet: newSet.
	table items: { newSet } , table items
]

{ #category : 'private - actions' }
OPUmlGeneralizationSetsOfControllerEditor >> addToSet: aSet [

	partOfSets add: aSet
]

{ #category : 'layout' }
OPUmlGeneralizationSetsOfControllerEditor >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: infoLabel;
				   add: addGeneralizationSetButton expand: false;
				   yourself)
		  expand: false;
		  add: table;
		  yourself
]

{ #category : 'private - actions' }
OPUmlGeneralizationSetsOfControllerEditor >> deleteSet: aSet [

	self removeFromSet: aSet.
	super deleteSet: aSet
]

{ #category : 'accessing' }
OPUmlGeneralizationSetsOfControllerEditor >> generalizationController: aController [
	"Backward compatibility setter"
	self controller: aController
]

{ #category : 'initialization' }
OPUmlGeneralizationSetsOfControllerEditor >> initializePresenters [

	super initializePresenters.
	infoLabel := self newLabel.
	infoLabel label: 'Check generalization sets to be part of'.
	addGeneralizationSetButton := self newButton.
	addGeneralizationSetButton
		label: 'New Set';
		iconName: 'add';
		action: [ self addNewSet ]
]

{ #category : 'initialization' }
OPUmlGeneralizationSetsOfControllerEditor >> initializeTable [

	table addColumn: (SpCheckBoxTableColumn new
			 title: 'Part of';
			 beNotExpandable;
			 width: 50;
			 evaluated: [ :gSet | partOfSets includes: gSet ];
			 onActivation: [ :gSet | self addToSet: gSet ];
			 onDeactivation: [ :gSet | self removeFromSet: gSet ]).

	super initializeTable
]

{ #category : 'actions' }
OPUmlGeneralizationSetsOfControllerEditor >> populateCommand: aCommand originalSets: originalSets newSetCopies: newSetCopies [
	| setsToCreate emptySets |
	super populateCommand: aCommand originalSets: originalSets newSetCopies: newSetCopies.
	setsToCreate := newSetCopies select: [ :eachCopy |
		originalSets noneSatisfy: [ :eachOriginalSet | eachOriginalSet uuid = eachCopy uuid ] ].
	setsToCreate do: [ :eachNewSet |
		aCommand recordAddSet: eachNewSet toPackage: self targetPackage ].
	originalSets do: [ :eachOriginalSet |
		| isPartOf isCurrentlyIn |
		isPartOf := partOfSets anySatisfy: [ :eachPartOfSet | eachPartOfSet uuid = eachOriginalSet uuid ].
		isCurrentlyIn := eachOriginalSet generalizations includes: self model.
		(isPartOf and: [ isCurrentlyIn not ]) ifTrue: [
			aCommand recordMembershipChangeOn: eachOriginalSet added: { self model } removed: #( ) ].
		(isPartOf not and: [ isCurrentlyIn ]) ifTrue: [
			aCommand recordMembershipChangeOn: eachOriginalSet added: #( ) removed: { self model } ] ].
	setsToCreate do: [ :eachNewSet |
		(partOfSets anySatisfy: [ :eachPartOfSet | eachPartOfSet uuid = eachNewSet uuid ]) ifTrue: [
			aCommand recordMembershipChangeOn: eachNewSet added: { self model } removed: #( ) ] ].
	emptySets := originalSets select: [ :eachOriginalSet |
		| remainingGeneralizations |
		remainingGeneralizations := eachOriginalSet generalizations copy.
		(partOfSets noneSatisfy: [ :eachPartOfSet | eachPartOfSet uuid = eachOriginalSet uuid ]) ifTrue: [
			remainingGeneralizations := remainingGeneralizations copyWithout: self model ].
		remainingGeneralizations isEmpty and: [ (aCommand isSetMarkedForRemoval: eachOriginalSet) not ] ].
	emptySets do: [ :eachEmptySet |
		| owningPackage |
		owningPackage := self packageForSet: eachEmptySet.
		aCommand recordRemoveSet: eachEmptySet fromPackage: owningPackage generalizations: eachEmptySet generalizations asArray ]
]

{ #category : 'actions' }
OPUmlGeneralizationSetsOfControllerEditor >> processChangesIn: originalSets basedOn: newSetCopies [

	| updatedSets |
	super processChangesIn: originalSets basedOn: newSetCopies.
	updatedSets := self processNewIn: originalSets basedOn: newSetCopies.
	self processInclusionsIn: updatedSets.
	self processEmptyIn: updatedSets
]

{ #category : 'actions' }
OPUmlGeneralizationSetsOfControllerEditor >> processEmptyIn: originalSets [

	| setsToRemove |
	setsToRemove := originalSets select: [ :each |
		                each generalizations isEmpty ].
	self processDoRemove: setsToRemove
]

{ #category : 'actions' }
OPUmlGeneralizationSetsOfControllerEditor >> processInclusionsIn: originalSets [
	originalSets do: [ :each |
		| isPartOf |
		isPartOf := partOfSets anySatisfy: [ :any | any uuid = each uuid ].
		isPartOf
			ifTrue: [ each generalizations addIfNotPresent: self model ]
			ifFalse: [ each generalizations remove: self model ifAbsent: [  ] ] ]
]

{ #category : 'actions' }
OPUmlGeneralizationSetsOfControllerEditor >> processNewIn: originalSets basedOn: newSetCopies [
	| setsToCreate |
	setsToCreate := newSetCopies select: [ :each |
		                originalSets noneSatisfy: [ :none |
			                none uuid = each uuid ] ].
	setsToCreate ifNotEmpty: [
		self packageViewModel model packagedElements addAll: setsToCreate ].
	^ originalSets , setsToCreate
]

{ #category : 'initialization' }
OPUmlGeneralizationSetsOfControllerEditor >> relevantGeneralizationSets [
	^ super relevantGeneralizationSets select: [ :each |
		  each generalizations anySatisfy: [ :any |
			  any general = self model general ] ]
]

{ #category : 'initialization' }
OPUmlGeneralizationSetsOfControllerEditor >> reloadGeneralizationSets [
	| relevantSets |
	relevantSets := self relevantGeneralizationSets collect: [ :each |
		                each copy ].
	partOfSets := relevantSets select: [ :each |
		              each generalizations includes: self model ].
	table items: relevantSets asOrderedCollection
]

{ #category : 'private - actions' }
OPUmlGeneralizationSetsOfControllerEditor >> removeFromSet: aSet [

	partOfSets removeAllSuchThat: [ :each | each uuid = aSet uuid ]
]

{ #category : 'updating' }
OPUmlGeneralizationSetsOfControllerEditor >> updateShapesOf: generalizations [
	super updateShapesOf: (generalizations copyWith: self model)
]
