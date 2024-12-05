Class {
	#name : 'OPUmlGeneralizationSetsEditor',
	#superclass : 'SpPresenter',
	#instVars : [
		'table',
		'controller'
	],
	#category : 'OpenPonk-ClassEditor-UI',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'UI'
}

{ #category : 'accessing' }
OPUmlGeneralizationSetsEditor >> controller: aController [

	controller := aController.
	self reloadGeneralizationSets
]

{ #category : 'private - actions' }
OPUmlGeneralizationSetsEditor >> deleteSet: aSet [

	| otherGeneralizations |
	otherGeneralizations := aSet generalizations copyWithout:
		                        controller model.
	otherGeneralizations ifNotEmpty: [
		(self confirm: 'This generalization set contains '
			 , (otherGeneralizations size pluralize: 'generalization')
			 ,
			 '. Those will not be removed, just no longer part of the set. Remove it?')
			ifFalse: [ ^ self ] ].
	table items: (table items reject: [ :any | any uuid = aSet uuid ])
]

{ #category : 'initialization' }
OPUmlGeneralizationSetsEditor >> initializePresenters [

	super initializePresenters.
	table := self newTable.
	self initializeTable
]

{ #category : 'initialization' }
OPUmlGeneralizationSetsEditor >> initializeTable [

	table
		addColumn: (SpStringTableColumn new
				 title: 'Name (editable)';
				 evaluated: #name;
				 beEditable;
				 onTextChanged: [ :gSet :text | gSet name: text ];
				 yourself);
		addColumn: (SpCheckBoxTableColumn new
				 title: 'Covering';
				 beNotExpandable;
				 width: 60;
				 evaluated: [ :gSet | gSet isCovering ];
				 onActivation: [ :gSet | gSet isCovering: true ];
				 onDeactivation: [ :gSet | gSet isCovering: false ]);
		addColumn: (SpCheckBoxTableColumn new
				 title: 'Disjoint';
				 beNotExpandable;
				 width: 60;
				 evaluated: [ :gSet | gSet isDisjoint ];
				 onActivation: [ :gSet | gSet isDisjoint: true ];
				 onDeactivation: [ :gSet | gSet isDisjoint: false ]);
		addColumn: (SpLinkTableColumn new
				 title: 'Delete';
				 beNotExpandable;
				 width: 60;
				 evaluated: [ :gSet | 'Delete' ];
				 action: [ :gSet | self deleteSet: gSet ])
]

{ #category : 'actions' }
OPUmlGeneralizationSetsEditor >> processChangesIn: originalSets basedOn: newSetCopies [

	originalSets do: [ :eachOriginalSet |
		| relevantCopy |
		relevantCopy := newSetCopies detect: [ :any |
			                any uuid = eachOriginalSet uuid ].
		eachOriginalSet name: relevantCopy name.
		eachOriginalSet isCovering: relevantCopy isCovering.
		eachOriginalSet isDisjoint: relevantCopy isDisjoint ]
]

{ #category : 'actions' }
OPUmlGeneralizationSetsEditor >> processDoRemove: setsToRemove [

	| uuids generalizations |
	uuids := setsToRemove collect: [ :each | each uuid ].
	controller diagramController allPackages do: [ :each |
		each packagedElements:
			(each packagedElements reject: [ :any | uuids includes: any uuid ]) ].
	setsToRemove do: [ :each |
		generalizations := each generalizations asSet.
		each generalizations: #(  ) ]
]

{ #category : 'actions' }
OPUmlGeneralizationSetsEditor >> processRemovalIn: originalSets basedOn: newSetCopies [

	| setsToRemove |
	setsToRemove := originalSets select: [ :each |
		                newSetCopies noneSatisfy: [ :any |
			                any uuid = each uuid ] ].
	self processDoRemove: setsToRemove.
	^ originalSets reject: [ :each |
		  setsToRemove anySatisfy: [ :any | any uuid = each uuid ] ]
]

{ #category : 'initialization' }
OPUmlGeneralizationSetsEditor >> relevantGeneralizationSets [

	| allElements packagedSets usedSets allSets |
	allElements := controller diagramController allModelElementsWithPossibleController.
	packagedSets := (allElements select: [ :each |
		                 each oclIsKindOf: #GeneralizationSet ]) asSet.
	usedSets := (allElements select: [ :each |
		             each respondsTo: #generalizations ]) flatCollectAsSet: [
		            :each |
		            each generalizations flatCollect: [ :eachGeneralization |
			            eachGeneralization generalizationSets ] ].
	allSets := packagedSets , usedSets.
	allSets do: [ :each | "make sure the uuid is set before making a copy"
		each uuid ].
	^ allSets
]

{ #category : 'initialization' }
OPUmlGeneralizationSetsEditor >> reloadGeneralizationSets [

	table items: (self relevantGeneralizationSets
			 collect: [ :each | each copy ]
			 as: OrderedCollection)
]

{ #category : 'actions' }
OPUmlGeneralizationSetsEditor >> save [

	| originalSets newSetCopies affectedGeneralizations |
	originalSets := self relevantGeneralizationSets.
	newSetCopies := table items.
	affectedGeneralizations := originalSets , newSetCopies
		                           flatCollectAsSet: [ :each |
		                           each generalizations ].
	originalSets := self
		                processRemovalIn: originalSets
		                basedOn: newSetCopies.
	self processChangesIn: originalSets basedOn: newSetCopies.
	self updateShapesOf: affectedGeneralizations
]

{ #category : 'as yet unclassified' }
OPUmlGeneralizationSetsEditor >> updateShapesOf: generalizations [

	generalizations do: [ :eachGeneralization |
		controller diagramController
			controllerForModel: eachGeneralization
			ifFound: [ :generalizationController |
			generalizationController modelChanged ] ]
]
