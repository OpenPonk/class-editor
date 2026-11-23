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

	(super deleteSet: aSet) ifFalse: [ ^ false ].
	self removeFromSet: aSet.
	^ true
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

{ #category : 'private - actions' }
OPUmlGeneralizationSetsOfControllerEditor >> populateCommand: aCommand originalSets: originalSets newSetCopies: newSetCopies [

	| setsToCreate emptySets |
	super populateCommand: aCommand originalSets: originalSets newSetCopies: newSetCopies.
	setsToCreate := newSetCopies select: [ :eachCopy |
			                (originalSets noneSatisfy: [ :eachOriginalSet | eachOriginalSet uuid = eachCopy uuid ]) and: [
				                partOfSets anySatisfy: [ :eachPartOfSet | eachPartOfSet uuid = eachCopy uuid ] ] ].
	setsToCreate do: [ :eachNewSet |
			aCommand recordAddSet: eachNewSet toPackage: self targetPackage.
			aCommand recordMembershipChangeOn: eachNewSet added: { self model } removed: #(  ) ].
	originalSets do: [ :eachOriginalSet |
			(aCommand isSetMarkedForRemoval: eachOriginalSet) ifFalse: [
					| isPartOf isCurrentlyIn |
					isPartOf := partOfSets anySatisfy: [ :eachPartOfSet | eachPartOfSet uuid = eachOriginalSet uuid ].
					isCurrentlyIn := eachOriginalSet generalizations includes: self model.
					(isPartOf and: [ isCurrentlyIn not ]) ifTrue: [
						aCommand recordMembershipChangeOn: eachOriginalSet added: { self model } removed: #(  ) ].
					(isPartOf not and: [ isCurrentlyIn ]) ifTrue: [
						aCommand recordMembershipChangeOn: eachOriginalSet added: #(  ) removed: { self model } ] ] ].
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

{ #category : 'initialization' }
OPUmlGeneralizationSetsOfControllerEditor >> relevantGeneralizationSets [
	^ super relevantGeneralizationSets select: [ :each |
		  each generalizations anySatisfy: [ :any |
			  any general = self model general ] ]
]

{ #category : 'initialization' }
OPUmlGeneralizationSetsOfControllerEditor >> reloadGeneralizationSets [

	| originalSets copies |
	originalSets := self relevantGeneralizationSets.
	copies := originalSets collect: [ :each | self copyGeneralizationSet: each ] as: OrderedCollection.
	partOfSets := (originalSets
		               select: [ :each | each generalizations includes: self model ]
		               thenCollect: [ :each | copies detect: [ :copySet | copySet uuid = each uuid ] ]) asOrderedCollection.
	table items: copies
]

{ #category : 'private - actions' }
OPUmlGeneralizationSetsOfControllerEditor >> removeFromSet: aSet [

	partOfSets removeAllSuchThat: [ :each | each uuid = aSet uuid ]
]
