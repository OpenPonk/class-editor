"
I represent an undoable command that updates generalization set memberships for a UML generalization.
"
Class {
	#name : 'OPUmlUpdateGeneralizationSetsCommand',
	#superclass : 'OPCommand',
	#instVars : [
		'setsToAdd',
		'setsToRemove',
		'propertyChanges',
		'membershipChanges',
		'viewModelRegistry',
		'affectedGeneralizations'
	],
	#category : 'OpenPonk-ClassEditor-Commands',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands'
}

{ #category : 'accessing' }
OPUmlUpdateGeneralizationSetsCommand >> affectedGeneralizations: aCollection [
	affectedGeneralizations := aCollection asSet
]

{ #category : 'accessing' }
OPUmlUpdateGeneralizationSetsCommand >> allAffectedGeneralizations [
	| result |
	result := affectedGeneralizations copy.
	membershipChanges do: [ :eachChange |
		result addAll: (eachChange at: #added).
		result addAll: (eachChange at: #removed) ].
	setsToRemove do: [ :eachChange |
		result addAll: (eachChange at: #generalizations) ].
	propertyChanges do: [ :eachChange |
		result addAll: (eachChange at: #set) generalizations ].
	^ result asSet
]

{ #category : 'execution' }
OPUmlUpdateGeneralizationSetsCommand >> execute [
	setsToAdd do: [ :eachPair |
		| generalizationSet owningPackage |
		generalizationSet := eachPair key.
		owningPackage := eachPair value.
		self assert: owningPackage isNotNil description: 'Cannot add generalization set to nil package'.
		owningPackage packagedElements addIfNotPresent: generalizationSet ].

	propertyChanges do: [ :eachChange |
		| generalizationSet |
		generalizationSet := eachChange at: #set.
		generalizationSet name: (eachChange at: #newName).
		generalizationSet isCovering: (eachChange at: #newIsCovering).
		generalizationSet isDisjoint: (eachChange at: #newIsDisjoint) ].

	membershipChanges do: [ :eachChange |
		| generalizationSet |
		generalizationSet := eachChange at: #set.
		(eachChange at: #added) do: [ :eachGeneralization |
			generalizationSet generalizations addIfNotPresent: eachGeneralization ].
		(eachChange at: #removed) do: [ :eachGeneralization |
			generalizationSet generalizations remove: eachGeneralization ifAbsent: [ ] ] ].

	setsToRemove do: [ :eachChange |
		| generalizationSet owningPackage |
		generalizationSet := eachChange at: #set.
		owningPackage := eachChange at: #package.
		self assert: owningPackage isNotNil description: 'Cannot remove generalization set from nil package'.
		generalizationSet generalizations removeAll.
		owningPackage packagedElements remove: generalizationSet ifAbsent: [ ] ].

	self notifyAffectedGeneralizations
]

{ #category : 'initialization' }
OPUmlUpdateGeneralizationSetsCommand >> initialize [
	super initialize.
	setsToAdd := OrderedCollection new.
	setsToRemove := OrderedCollection new.
	propertyChanges := OrderedCollection new.
	membershipChanges := OrderedCollection new.
	affectedGeneralizations := Set new
]

{ #category : 'testing' }
OPUmlUpdateGeneralizationSetsCommand >> isEmpty [
	^ setsToAdd isEmpty
		and: [ setsToRemove isEmpty
		and: [ propertyChanges isEmpty
		and: [ membershipChanges isEmpty ] ] ]
]

{ #category : 'testing' }
OPUmlUpdateGeneralizationSetsCommand >> isSetMarkedForRemoval: aSet [
	^ setsToRemove anySatisfy: [ :each | (each at: #set) uuid = aSet uuid ]
]

{ #category : 'execution' }
OPUmlUpdateGeneralizationSetsCommand >> notifyAffectedGeneralizations [
	viewModelRegistry ifNil: [ ^ self ].
	self allAffectedGeneralizations do: [ :eachGeneralization |
		(viewModelRegistry hasViewModelFor: eachGeneralization) ifTrue: [
			(viewModelRegistry viewModelFor: eachGeneralization) modelChanged ] ]
]

{ #category : 'building' }
OPUmlUpdateGeneralizationSetsCommand >> recordAddSet: aSet toPackage: aPackage [
	setsToAdd add: aSet -> aPackage
]

{ #category : 'building' }
OPUmlUpdateGeneralizationSetsCommand >> recordMembershipChangeOn: aSet added: addedGens removed: removedGens [
	membershipChanges add: (Dictionary new
		at: #set put: aSet;
		at: #added put: addedGens;
		at: #removed put: removedGens;
		yourself)
]

{ #category : 'building' }
OPUmlUpdateGeneralizationSetsCommand >> recordPropertyChangeOn: aSet oldName: oldName newName: newName oldIsCovering: oldIsCovering newIsCovering: newIsCovering oldIsDisjoint: oldIsDisjoint newIsDisjoint: newIsDisjoint [
	propertyChanges add: (Dictionary new
		at: #set put: aSet;
		at: #oldName put: oldName;
		at: #newName put: newName;
		at: #oldIsCovering put: oldIsCovering;
		at: #newIsCovering put: newIsCovering;
		at: #oldIsDisjoint put: oldIsDisjoint;
		at: #newIsDisjoint put: newIsDisjoint;
		yourself)
]

{ #category : 'building' }
OPUmlUpdateGeneralizationSetsCommand >> recordRemoveSet: aSet fromPackage: aPackage generalizations: aCollection [
	setsToRemove add: (Dictionary new
		at: #set put: aSet;
		at: #package put: aPackage;
		at: #generalizations put: aCollection;
		yourself)
]

{ #category : 'execution' }
OPUmlUpdateGeneralizationSetsCommand >> undo [
	setsToRemove reverseDo: [ :eachChange |
		| generalizationSet owningPackage originalGeneralizations |
		generalizationSet := eachChange at: #set.
		owningPackage := eachChange at: #package.
		originalGeneralizations := eachChange at: #generalizations.
		self assert: owningPackage isNotNil description: 'Cannot restore generalization set to nil package'.
		owningPackage packagedElements addIfNotPresent: generalizationSet.
		originalGeneralizations do: [ :eachGeneralization |
			generalizationSet generalizations addIfNotPresent: eachGeneralization ] ].

	membershipChanges reverseDo: [ :eachChange |
		| generalizationSet |
		generalizationSet := eachChange at: #set.
		(eachChange at: #added) do: [ :eachGeneralization |
			generalizationSet generalizations remove: eachGeneralization ifAbsent: [ ] ].
		(eachChange at: #removed) do: [ :eachGeneralization |
			generalizationSet generalizations addIfNotPresent: eachGeneralization ] ].

	propertyChanges reverseDo: [ :eachChange |
		| generalizationSet |
		generalizationSet := eachChange at: #set.
		generalizationSet name: (eachChange at: #oldName).
		generalizationSet isCovering: (eachChange at: #oldIsCovering).
		generalizationSet isDisjoint: (eachChange at: #oldIsDisjoint) ].

	setsToAdd reverseDo: [ :eachPair |
		| generalizationSet owningPackage |
		generalizationSet := eachPair key.
		owningPackage := eachPair value.
		self assert: owningPackage isNotNil description: 'Cannot undo added generalization set from nil package'.
		generalizationSet generalizations removeAll.
		owningPackage packagedElements remove: generalizationSet ifAbsent: [ ] ].

	self notifyAffectedGeneralizations
]

{ #category : 'accessing' }
OPUmlUpdateGeneralizationSetsCommand >> viewModelRegistry: aRegistry [
	viewModelRegistry := aRegistry
]
