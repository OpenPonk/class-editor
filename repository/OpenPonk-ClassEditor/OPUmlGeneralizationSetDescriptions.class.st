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
	#category : 'OpenPonk-ClassEditor-Forms'
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

{ #category : #accessing }
OPUmlGeneralizationSetDescriptions >> set [
	^ set
]

{ #category : #accessing }
OPUmlGeneralizationSetDescriptions >> set: aGeneralizationSet [
	set := aGeneralizationSet
]
