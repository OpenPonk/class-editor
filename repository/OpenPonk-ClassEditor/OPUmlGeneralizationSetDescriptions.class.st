"
I am a description proxy for a generalization set and I collaborate with GeneralizationController.
"
Class {
	#name : #OPUmlGeneralizationSetDescriptions,
	#superclass : #Object,
	#instVars : [
		'set',
		'controller'
	],
	#category : #'OpenPonk-ClassEditor-Forms'
}

{ #category : #comparing }
OPUmlGeneralizationSetDescriptions >> = aDescription [
	self species = aDescription species
		ifFalse: [ ^ false ].
	^ self set = aDescription set
]

{ #category : #accessing }
OPUmlGeneralizationSetDescriptions >> controller [
	^ controller
]

{ #category : #accessing }
OPUmlGeneralizationSetDescriptions >> controller: anObject [
	controller := anObject
]

{ #category : #accessing }
OPUmlGeneralizationSetDescriptions >> descriptionAccessor: aSymbol [
	^ MAPluggableAccessor
		read: [ :me | set perform: aSymbol ]
		write: [ :me :newValue | 
			set perform: (aSymbol , ':') asSymbol with: newValue.
			controller diagramElement ifNotNil: [ controller refreshFigure ] ]
]

{ #category : #forms }
OPUmlGeneralizationSetDescriptions >> descriptionIsCovering [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isCovering);
		label: 'Is Covering';
		priority: 10;
		yourself
]

{ #category : #forms }
OPUmlGeneralizationSetDescriptions >> descriptionIsDisjoint [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isDisjoint);
		label: 'Is Disjoint';
		priority: 11;
		yourself
]

{ #category : #forms }
OPUmlGeneralizationSetDescriptions >> descriptionName [
	<magritteDescription>
	^ MAStringDescription new
		accessor: (self descriptionAccessor: #name);
		label: 'Name';
		priority: 1;
		yourself
]

{ #category : #forms }
OPUmlGeneralizationSetDescriptions >> descriptionVisibility [
	<magritteDescription>
	^ MASingleOptionDescription new
		optionsAndLabels:
			{OPUMLVisibilityKind public -> 'public'.
			OPUMLVisibilityKind protected -> 'protected'.
			OPUMLVisibilityKind private -> 'private'.
			OPUMLVisibilityKind new package -> 'package'};
		morphClass: MADropListMorph;
		reference: MAStringDescription new;
		accessor: (self descriptionAccessor: #visibility);
		label: 'Visibility';
		priority: 4;
		beSorted;
		yourself
]

{ #category : #comparing }
OPUmlGeneralizationSetDescriptions >> hash [
	^ super hash bitXor: set hash
]

{ #category : #forms }
OPUmlGeneralizationSetDescriptions >> initializeFor: aGeneralizationController [
	| dialog listPresenter allElements setsToDisplay |
	self controller: aGeneralizationController.
	dialog := SpVersatileDialogPresenter new.
	allElements := aGeneralizationController diagramController model
		packagedElements.
	setsToDisplay := ((allElements
		select: [ :each | each oclIsKindOf: #GeneralizationSet ])
		,
			((allElements select: [ :each | each respondsTo: #generalizations ])
				flatCollectAsSet: [ :each | 
					each generalizations
						flatCollectAsSet: [ :eachGeneralization | eachGeneralization generalizationSets ] ])
				asArray) asSet asArray
		select: [ :each | 
			each generalizations
				anySatisfy: [ :any | any general = aGeneralizationController model general ] ].
	setsToDisplay
		ifEmpty: [ ^ self
				set: OPUMLGeneralizationSet new;
				yourself ].
	listPresenter := dialog newList.
	listPresenter
		items: setsToDisplay;
		display: [ :each | 
			String
				streamContents: [ :stream | 
					stream
						<< 'GeneralizationSet {''';
						<< (each name ifNil: [ '' ]);
						<< ''', '.
					each isCovering
						ifTrue: [ stream << 'complete, ' ]
						ifFalse: [ stream << 'incomplete, ' ].
					each isDisjoint
						ifTrue: [ stream << 'disjoint, ' ]
						ifFalse: [ stream << 'overlapping, ' ].
					stream << ('(' , each generalizations size asString , ')}') ] ].
	dialog contentArea: listPresenter.
	dialog
		addButton: #select
		text: 'Select existing from list'
		value: [ listPresenter selection selectedItem ]
		condition: [ listPresenter selection selectedItems size = 1 ].
	dialog
		addButton: #new
		text: 'Create new'
		value: [ OPUMLGeneralizationSet new ].
	dialog openModalWithSpec.
	dialog withWindowDo: [ :w | w title: 'Select existing or new set' ].
	self set: dialog result value
]

{ #category : #accessing }
OPUmlGeneralizationSetDescriptions >> set [
	^ set
]

{ #category : #accessing }
OPUmlGeneralizationSetDescriptions >> set: aGeneralizationSet [
	set := aGeneralizationSet
]
