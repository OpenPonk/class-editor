"
I am a controller for Association
"
Class {
	#name : 'OPUmlAssociationController',
	#superclass : 'OPUmlAbstractAssociationController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'testing' }
OPUmlAssociationController >> canSwitchSourceAndTarget [
	^ self model isNotNil and: [ self model memberEnds size = 2 ]
]

{ #category : 'as yet unclassified' }
OPUmlAssociationController >> descriptionActionSwitchSourceTarget [

	<magritteDescription>
	| description |
	self canSwitchSourceAndTarget ifFalse: [ ^ self ].
	description := OPMAActionDescription new.
	description
		action: [
			self switchSourceAndTarget.
			self diagramController editor openFormOn: self.
			self modelChanged ];
		label: 'Switch source/target';
		priority: 9.05.
	^ description
]

{ #category : 'forms' }
OPUmlAssociationController >> descriptionIsDerived [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isDerived);
		label: 'Is Derived';
		priority: 7;
		yourself
]

{ #category : 'forms' }
OPUmlAssociationController >> descriptionSeparator [
	<magritteDescription>
	^ MAPriorityContainer new priority: 9
]

{ #category : 'forms' }
OPUmlAssociationController >> descriptionSourceEnd [
	<magritteDescription>
	^ MAPriorityContainer new
		priority: 9.1;
		addAll:
			(OPUmlPropertyMagritteDescriptions
				reader: [ :me | me model memberEnds first ]
				labelPrefix: 'Source ') magritteDescription
]

{ #category : 'forms' }
OPUmlAssociationController >> descriptionStereotype [

	<magritteDescription>
	^ self descriptionStereotypeContent
]

{ #category : 'forms' }
OPUmlAssociationController >> descriptionTargetEnd [
	<magritteDescription>
	^ MAPriorityContainer new
		priority: 9.2;
		addAll:
			(OPUmlPropertyMagritteDescriptions
				reader: [ :me | me model memberEnds second ]
				labelPrefix: 'Target ') magritteDescription
]

{ #category : 'construction' }
OPUmlAssociationController >> diagramElementClass [

	^ OPUmlAssociationShape
]

{ #category : 'accessing' }
OPUmlAssociationController >> modelClass [
	^ OPUMLAssociation
]

{ #category : 'construction' }
OPUmlAssociationController >> modelSource: aModel in: aParentModel [

	| property |
	self modelSource = aModel ifTrue: [ ^ false ].
	(property := OPUMLProperty new)
		owningAssociation: self model;
		name: (source model name uncapitalized
				 replaceAll: Character cr
				 with: Character space);
		type: source model.
	self model memberEnds add: property.
	^ true
]

{ #category : 'construction' }
OPUmlAssociationController >> modelTarget: aModel in: aParentModel [

	| property |
	self modelTarget = aModel ifTrue: [ ^ false ].
	(property := OPUMLProperty new)
		owningAssociation: self model;
		name: (target model name uncapitalized
				 replaceAll: Character cr
				 with: Character space);
		type: target model.
	self model memberEnds add: property.
	^ true
]

{ #category : 'construction' }
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
		          originalModels second type.
	self diagramElement switchSourceAndTarget
]

{ #category : 'writing' }
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

{ #category : 'writing' }
OPUmlAssociationController >> writeNavigability: isNavigable to: aProperty [

	isNavigable
		ifTrue: [
			aProperty owningClass: aProperty opposite type.
			aProperty owningAssociation: nil.
			self diagramController showInDiagramModel: aProperty ]
		ifFalse: [
			aProperty owningClass: nil.
			aProperty owningAssociation: aProperty association.
			self diagramController
				controllerForModel: aProperty
				ifFound: [ :found | found removeControllerAndDiagramElement ] ]
]
