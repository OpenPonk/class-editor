"
I am a controller for Association
"
Class {
	#name : #OPUmlAssociationController,
	#superclass : #OPUmlRelationshipController,
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #testing }
OPUmlAssociationController >> canSwitchSourceAndTarget [

	^ self model isNotNil and: [ self model memberEnds size >= 2 ]
]

{ #category : #figures }
OPUmlAssociationController >> createDiagramElement [
	^ OPUmlAssociationShape new
		modelElement: self model;
		yourself
]

{ #category : #construction }
OPUmlAssociationController >> createModelIn: aClass [
	| sourceProp targetProp |
	self model: self modelClass new.
	(sourceProp := OPUMLProperty new)
		owningAssociation: self model;
		name: source model name uncapitalized;
		type: source model.
	(targetProp := OPUMLProperty new)
		owningAssociation: self model;
		name: aClass name uncapitalized;
		type: aClass.
	source diagramController model packagedElements add: self model.
	model memberEnds
		add: sourceProp;
		add: targetProp.
	^ model
]

{ #category : #accessing }
OPUmlAssociationController >> dependentElements [
	^ model memberEnds
]

{ #category : #forms }
OPUmlAssociationController >> descriptionIsDerived [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isDerived);
		label: 'Is Derived';
		priority: 7;
		yourself
]

{ #category : #forms }
OPUmlAssociationController >> descriptionSeparator [
	<magritteDescription>
	^ MAPriorityContainer new priority: 9
]

{ #category : #forms }
OPUmlAssociationController >> descriptionSourceEnd [
	<magritteDescription>
	^ MAPriorityContainer new
		priority: 9.1;
		addAll:
			(OPUmlPropertyMagritteDescriptions
				reader: [ :me | me model memberEnds first ]
				labelPrefix: 'Source ') magritteDescription
]

{ #category : #forms }
OPUmlAssociationController >> descriptionStereotype [
	<magritteDescription>
	^ super descriptionStereotype
]

{ #category : #'as yet unclassified' }
OPUmlAssociationController >> descriptionSwitchSourceTarget [

	<magritteDescription>
	| description |
	description := MABooleanDescription new
		               accessor:
			               (MAPluggableAccessor
				                read: [ :me | false ]
				                write: [ :me :newValue | 
					                self switchSourceAndTarget.
					                self diagramController editor workbench 
						                openFormOn: self.
					                self reactToAttributeWrite ]);
		               label: 'Switch source/target';
		               comment: '';
		               priority: 9.05.
	self canSwitchSourceAndTarget ifFalse: [ description beHidden ].
	^ description
]

{ #category : #forms }
OPUmlAssociationController >> descriptionTargetEnd [
	<magritteDescription>
	^ MAPriorityContainer new
		priority: 9.2;
		addAll:
			(OPUmlPropertyMagritteDescriptions
				reader: [ :me | me model memberEnds second ]
				labelPrefix: 'Target ') magritteDescription
]

{ #category : #accessing }
OPUmlAssociationController >> modelClass [
	^ OPUMLAssociation
]

{ #category : #accessing }
OPUmlAssociationController >> pathSourceModel [
	^ model memberEnds first type
]

{ #category : #rendering }
OPUmlAssociationController >> refreshFigure [
	self diagramElement changed.
	^ self figure
]

{ #category : #removing }
OPUmlAssociationController >> removeModel [
	self diagramController model packagedElements remove: self model.
	self model memberEnds
		select: [ :each | each owningClass isNotNil ]
		thenDo: [ :eachProperty | eachProperty owningClass: nil ].
	self model memberEnds: #()
]

{ #category : #rendering }
OPUmlAssociationController >> renderFigureIn: aView [
	self diagramController addingFigureFor: self.
	diagramElement := self createDiagramElement.
	diagramElement
		ends:
			{diagramController diagramElementForModel: self model memberEnds first type.
			diagramController diagramElementForModel: self model memberEnds second type}.
	diagramElement renderIn: aView.
	diagramController addedFigureFor: self.
	^ self refreshFigure
]

{ #category : #construction }
OPUmlAssociationController >> switchSourceAndTarget [

	| originalModels |
	self canSwitchSourceAndTarget ifFalse: [ ^ self ].
	originalModels := self model memberEnds asArray.
	self model memberEnds removeAll.
	self model memberEnds add: originalModels second.
	self model memberEnds add: originalModels first.
	3 to: originalModels size do: [ :index | 
	self model memberEnds add: originalModels at: index ].
	source := self diagramController controllerForModel:
		          originalModels second type
]

{ #category : #writing }
OPUmlAssociationController >> writeMultiplicityFrom: aString to: aProperty [
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

{ #category : #writing }
OPUmlAssociationController >> writeNavigability: isNavigable to: aProperty [
	isNavigable
		ifTrue: [ aProperty owningClass: aProperty opposite type.
			aProperty owningAssociation: nil ]
		ifFalse: [ aProperty owningClass: nil.
			aProperty owningAssociation: aProperty association ]
]
