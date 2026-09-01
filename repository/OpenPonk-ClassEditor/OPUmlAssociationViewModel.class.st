"
I act as the ViewModel for a UML Association. I manage the domain logic for connecting source and target classifiers, updating end multiplicities and navigability, handling stereotype applications, and swapping association directions.
"
Class {
	#name : 'OPUmlAssociationViewModel',
	#superclass : 'OPUmlElementViewModel',
	#traits : 'OPTUmlPackageableElementViewModel',
	#classTraits : 'OPTUmlPackageableElementViewModel classTrait',
	#category : 'OpenPonk-ClassEditor-ViewModels',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPUmlAssociationViewModel class >> modelClass [ ^ OPUMLAssociation
]

{ #category : 'construction' }
OPUmlAssociationViewModel >> attachModelFrom: sourceViewModel to: targetViewModel [

	self model memberEnds add: (OPUMLProperty new
			 owningAssociation: self model;
			 name: (sourceViewModel model name uncapitalized
					  copyReplaceAll: String cr
					  with: String space);
			 type: sourceViewModel model).
	self model memberEnds add: (OPUMLProperty new
			 owningAssociation: self model;
			 name: (targetViewModel model name uncapitalized
					  copyReplaceAll: String cr
					  with: String space);
			 type: targetViewModel model)
]

{ #category : 'testing' }
OPUmlAssociationViewModel >> canSwitchSourceAndTarget [
	^ true
]

{ #category : 'accessing' }
OPUmlAssociationViewModel >> childrenModels [

	^ self model ownedEnds asArray
]

{ #category : 'accessing' }
OPUmlAssociationViewModel >> dependentElements [

	^ self model memberEnds asArray
]

{ #category : 'accessing' }
OPUmlAssociationViewModel >> dependingOnElements [

	^ super dependingOnElements
	  , (self model memberEnds collect: [ :each | each type ])
]

{ #category : 'forms' }
OPUmlAssociationViewModel >> descriptionActionSwitchSourceTarget [
	<magritteDescription>
	| description |
	self canSwitchSourceAndTarget ifFalse: [ ^ self ].
	description := OPMAActionDescription new.
	description
		action: [ self switchSourceAndTarget ];
		label: 'Switch source/target';
		priority: 9.05.
	^ description
]

{ #category : 'forms' }
OPUmlAssociationViewModel >> descriptionIsDerived [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isDerived);
		label: 'Is Derived';
		priority: 7;
		yourself
]

{ #category : 'forms' }
OPUmlAssociationViewModel >> descriptionSeparator [
	<magritteDescription>
	^ MAPriorityContainer new priority: 9
]

{ #category : 'forms' }
OPUmlAssociationViewModel >> descriptionSourceEnd [
	<magritteDescription>
	^ MAPriorityContainer new
		priority: 9.1;
		addAll:
			(OPUmlPropertyMagritteDescriptions
				reader: [ :me | me model memberEnds first ]
				labelPrefix: 'Source ') magritteDescription
]

{ #category : 'forms' }
OPUmlAssociationViewModel >> descriptionStereotype [

	<magritteDescription>
	^ self descriptionStereotypeContent
]

{ #category : 'forms' }
OPUmlAssociationViewModel >> descriptionTargetEnd [
	<magritteDescription>
	^ MAPriorityContainer new
		priority: 9.2;
		addAll:
			(OPUmlPropertyMagritteDescriptions
				reader: [ :me | me model memberEnds second ]
				labelPrefix: 'Target ') magritteDescription
]

{ #category : 'accessing' }
OPUmlAssociationViewModel >> icon [ ^ OPUmlIcons directedAssociationIcon
]

{ #category : 'printing' }
OPUmlAssociationViewModel >> modelDisplayStringOn: aStream [
    self model name ifNotNil: [ :n | n ifNotEmpty: [ aStream nextPutAll: n; space ] ].
    self model memberEnds size = 2 ifTrue: [
        | n1 n2 |
        n1 := self model memberEnds first type ifNotNil: #name ifNil: ['?'].
        n2 := self model memberEnds second type ifNotNil: #name ifNil: ['?'].
        aStream nextPutAll: '['.
        aStream nextPutAll: (n1 truncateWithElipsisTo: 20).
        aStream nextPutAll: ' -> '.
        aStream nextPutAll: (n2 truncateWithElipsisTo: 20).
        aStream nextPutAll: ']' ].
    aStream space.
    aStream nextPutAll: '('.
    aStream nextPutAll: self model umlClassName.
    aStream nextPutAll: ')'
]

{ #category : 'accessing' }
OPUmlAssociationViewModel >> modelSource [

	^ self model memberEnds ifNotEmpty: [ :memberEnds |
		  memberEnds first type ]
]

{ #category : 'accessing' }
OPUmlAssociationViewModel >> modelTarget [

	^ self model memberEnds size > 1
		  ifTrue: [ self model memberEnds second type ]
		  ifFalse: [ nil ]
]

{ #category : 'construction' }
OPUmlAssociationViewModel >> registerModelIn: aParentModel [
	aParentModel ifNotNil: [ aParentModel packagedElements add: self model ]
]

{ #category : 'actions' }
OPUmlAssociationViewModel >> switchSourceAndTarget [
	| originalModels |
	self canSwitchSourceAndTarget ifFalse: [ ^ self ].
	originalModels := self model memberEnds asArray.
	self model memberEnds removeAll.
	self model memberEnds add: originalModels second.
	self model memberEnds add: originalModels first.
	3 to: originalModels size do: [ :index |
		self model memberEnds add: originalModels at: index ].
		
	self announcer announce: OPAssociationEndsSwapped new.
	self announcer announce: OPElementFormNeedsRebuild new.
	self modelChanged
]

{ #category : 'validation' }
OPUmlAssociationViewModel >> validate [

	super validate.
	self validateMemberEndCount.
	self model memberEnds do: [ :each | self validateProperty: each ].
	self model attributes do: [ :each | self validateProperty: each ]
]

{ #category : 'validation' }
OPUmlAssociationViewModel >> validateMemberEndCount [

	self model memberEnds size = 2 ifTrue: [ ^ self ].

	OPModelInvalid signal: (String streamContents: [ :s |
			 s << self model asString << '" has '
			 << self model memberEnds size asString
			 << ' memberEnds instead of 2' ])
]

{ #category : 'parsing' }
OPUmlAssociationViewModel >> writeMultiplicityFrom: aString to: aProperty [
	| values |
	(aString includesSubstring: '..')
		ifTrue: [ | split |
			split := aString splitOn: '..'.
			values := {split first asNumber.
			split second = '*'
				ifTrue: [ '*' ]
				ifFalse: [ split second asNumber ]} ]
		ifFalse: [ aString = '*'
				ifTrue: [ values := #(0 '*') ]
				ifFalse: [ values := {aString asNumber.
					aString asNumber} ] ].
	aProperty lowerValue ifNil: [ aProperty lowerValue: OPUMLLiteralInteger new ].
	aProperty upperValue ifNil: [ aProperty upperValue: OPUMLLiteralUnlimitedNatural new ].
	aProperty lowerValue value: values first.
	aProperty upperValue value: values second
]

{ #category : 'parsing' }
OPUmlAssociationViewModel >> writeNavigability: isNavigable to: aProperty [
	isNavigable
		ifTrue: [
			aProperty owningClass: aProperty opposite type.
			aProperty owningAssociation: nil ]
		ifFalse: [
			aProperty owningClass: nil.
			aProperty owningAssociation: aProperty association ].
	self announcer announce: (OPUmlNavigabilityChanged property: aProperty)
]
