"
I am a base class for diagram element controllers.
"
Class {
	#name : #OPUmlElementController,
	#superclass : #OPElementController,
	#instVars : [
		'diagramElement'
	],
	#category : 'OpenPonk-ClassEditor-Controllers'
}

{ #category : #forms }
OPUmlElementController >> applyStereotype: aStereotypeModel to: aModel [
	(aModel appliedStereotypes
		anySatisfy: [ :each | each umlClassName = aStereotypeModel umlClassName ])
		ifTrue: [ ^ self ].
	self removeStereotypesIn: aModel.
	aModel applyStereotype: aStereotypeModel implementationClass new
]

{ #category : #forms }
OPUmlElementController >> buildAbstractEditorForm: aForm [
	(aForm addCheckbox: 'Is Abstract')
		state: self model isAbstract;
		whenChangedDo: [ :val | 
			self model isAbstract: val.
			self refreshFigure ]
]

{ #category : #forms }
OPUmlElementController >> buildEditorForm: aForm [
	aForm fromMagritteDescriptions: self magritteDescription
]

{ #category : #forms }
OPUmlElementController >> buildNameEditorForm: aForm [
	(aForm addTextInput: 'Name')
		text: self model name;
		whenTextIsAccepted: [ :newValue | 
			self model name: newValue.
			self refreshFigure ]
]

{ #category : #figures }
OPUmlElementController >> createDiagramElement [
	^ self subclassResponsibility
]

{ #category : #figures }
OPUmlElementController >> createFigure [
	^ self shouldNotImplement
]

{ #category : #model }
OPUmlElementController >> createModel [
	^ self modelClass new
]

{ #category : #forms }
OPUmlElementController >> descriptionAccessor: aSymbol [
	^ MAPluggableAccessor
		read: [ :me | me model perform: aSymbol ]
		write: [ :me :newValue | 
			me model perform: (aSymbol , ':') asSymbol with: newValue.
			diagramElement ifNotNil: [ self refreshFigure ] ]
]

{ #category : #forms }
OPUmlElementController >> descriptionComment [
	<magritteDescription>
	^ MAMemoDescription new
		required: false;
		accessor:
			(MAPluggableAccessor
				read:
					[ :me | me model ownedComments ifEmpty: [ '' ] ifNotEmpty: [ :oc | oc first body asString ] ]
				write: [ :me :newValue | 
					me model ownedComments ifEmpty: [ me model ownedComments add: OPUMLComment new ].
					me model ownedComments first body: newValue asString ]);
		label: 'Comment';
		priority: 100;
		yourself
]

{ #category : #forms }
OPUmlElementController >> descriptionModelInfo [
	<magritteDescription>
	^ MAStringDescription new
		beReadonly;
		accessor: (MAPluggableAccessor read: [ :me | '' ] write: [ :me :newValue |  ]);
		label: self model className;
		priority: 0;
		yourself
]

{ #category : #forms }
OPUmlElementController >> descriptionName [
	<magritteDescription>
	^ MAStringDescription new
		accessor: (self descriptionAccessor: #name);
		label: 'Name';
		priority: 1;
		yourself
]

{ #category : #forms }
OPUmlElementController >> descriptionStereotype [
	| profile names stereotypes |
	profile := self diagramController model profileApplications
		ifEmpty: [ ^ nil ]
		ifNotEmpty: [ :col | col first appliedProfile ].
	stereotypes := self stereotypesIn: profile for: self model.
	names := stereotypes asArray collect: [ :each | each name -> each name ].
	^ MASingleOptionDescription new
		optionsAndLabels: {nil -> ''} , names;
		accessor:
			(MAPluggableAccessor
				read: [ :me | 
					me model appliedStereotypes
						ifEmpty: [ nil ]
						ifNotEmpty: [ :col | col first umlClassName ] ]
				write: [ :me :newValue | 
					newValue
						ifNil: [ self removeStereotypesIn: me model ]
						ifNotNil: [ self
								applyStereotype: (stereotypes detect: [ :each | each name = newValue ])
								to: me model ].
					me refreshFigure.
					me refreshFigure ]);
		label: 'Stereotype';
		priority: 4;
		yourself
]

{ #category : #forms }
OPUmlElementController >> descriptionVisibility [
	<magritteDescription>
	^ MASingleOptionDescription new
		optionsAndLabels:
			{nil -> ''.
			OPUMLVisibilityKind public -> 'public'.
			OPUMLVisibilityKind protected -> 'protected'.
			OPUMLVisibilityKind private -> 'private'.
			OPUMLVisibilityKind new package -> 'package'};
		reference: MAStringDescription new;
		accessor:
			(MAPluggableAccessor
				read: [ :me | me model visibility ]
				write: [ :me :newValue | 
					me model visibility: newValue.
					self refreshFigure ]);
		label: 'Visibility';
		priority: 8;
		beSorted;
		yourself
]

{ #category : #figures }
OPUmlElementController >> diagramElement [
	^ diagramElement
]

{ #category : #figures }
OPUmlElementController >> figure [
	^ self diagramElement rtElement
]

{ #category : #accessing }
OPUmlElementController >> magritteDescription [
	| container |
	container := MAPragmaBuilder for: self.
	container addAll: self stereotypeMagritteDescription.
	^ container
]

{ #category : #model }
OPUmlElementController >> remove [
	self removeFigure.
	diagramController removeController: self
]

{ #category : #figures }
OPUmlElementController >> removeDiagramElement [
	self diagramController deselectAll.
	diagramElement view
		ifNotNil: [ 
			diagramElement remove.
			diagramElement := nil ]
]

{ #category : #figures }
OPUmlElementController >> removeFigure [
	self removeDiagramElement
]

{ #category : #model }
OPUmlElementController >> removeModel [
	self subclassResponsibility
	
]

{ #category : #removing }
OPUmlElementController >> removeStereotypesIn: aModel [
	[ aModel appliedStereotypes isNotEmpty ]
		whileTrue: [ aModel unapplyStereotype: aModel appliedStereotypes first ]
]

{ #category : #figures }
OPUmlElementController >> renderFigureIn: aView [
	self subclassResponsibility
]

{ #category : #accessing }
OPUmlElementController >> stereotypeMagritteDescription [
	| descriptions |
	descriptions := OPUmlSteretypeDescriptions new controller: self.
	^ descriptions descriptions
]

{ #category : #'as yet unclassified' }
OPUmlElementController >> stereotypesIn: aProfile for: aModel [
	^ (aProfile ownedStereotype reject: #isAbstract)
		select: [ :stereo | 
			stereo allAttributes
				anySatisfy: [ :each | (each name beginsWith: 'base_') and: [ self model oclIsKindOf: each type name ] ] ]
]
