"
I am a controller for Association
"
Class {
	#name : #OPUmlAssociationController,
	#superclass : #OPUmlRelationshipController,
	#category : 'OpenPonk-ClassEditor-Controllers'
}

{ #category : #figures }
OPUmlAssociationController >> createDiagramElement [
	^ OPUmlAssociationShape new
		modelElement: self model;
		yourself
]

{ #category : #construction }
OPUmlAssociationController >> createModelIn: aTargetController andShowInDiagram: aDiagramController [
	| sourceProp targetProp |
	self model: self createModel.
	(sourceProp := OPUMLProperty new)
		owningClass: aTargetController model;
		name: sourceController model name uncapitalized;
		type: sourceController model.
	(targetProp := OPUMLProperty new)
		owningClass: sourceController model;
		name: aTargetController model name uncapitalized;
		type: aTargetController model.
	model memberEnds
		add: sourceProp;
		add: targetProp.
	aDiagramController model packagedElements add: model.
	aDiagramController addController: self.
	self showInDiagram: aDiagramController.
	model memberEnds
		do: [ :each | 
			| subCtrl |
			subCtrl := aDiagramController newControllerFor: each.
			aDiagramController addController: subCtrl.
			subCtrl showInDiagram: aDiagramController ]
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

{ #category : #rendering }
OPUmlAssociationController >> refreshFigure [
	self diagramElement changed
]

{ #category : #removing }
OPUmlAssociationController >> removeModel [
	| owner ownerController |
	ownerController := self diagramController.
	owner := ownerController model.
	self remove.
	owner packagedElements remove: self model.
	[ self model memberEnds isNotEmpty ]
		whileTrue: [ ownerController
				controllerForModel:
					(self model memberEnds anyOne
						association: nil;
						owningClass: nil;
						owningAssociation: nil;
						yourself)
				ifFound: [ :ctrl | ctrl removeModel ] ]
]

{ #category : #rendering }
OPUmlAssociationController >> renderFigureIn: aView [
	diagramElement := self createDiagramElement.
	diagramElement
		ends:
			{diagramController diagramElementForModel: self model memberEnds first type.
			diagramController diagramElementForModel: self model memberEnds second type}.
	diagramElement renderIn: aView.
	diagramController figureAdded: self figure.
	self refreshFigure
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
