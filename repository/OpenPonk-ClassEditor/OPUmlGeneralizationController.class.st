"
I am a controller for UML Generalization.
"
Class {
	#name : #OPUmlGeneralizationController,
	#superclass : #OPUmlRelationshipController,
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #figures }
OPUmlGeneralizationController >> createDiagramElement [
	^ OPUmlGeneralizationShape new
		modelElement: self model;
		yourself
]

{ #category : #figures }
OPUmlGeneralizationController >> createModelIn: aTargetController andShowInDiagram: aDiagramController [
	self model: OPUMLGeneralization new.
	model general: aTargetController model.
	model specific: source model.
	aDiagramController addController: self.
	self showInDiagram: aDiagramController
]

{ #category : #forms }
OPUmlGeneralizationController >> descriptionGeneral [
	<magritteDescription>
	^ MAStringDescription new
		beReadonly;
		accessor:
			(MAPluggableAccessor read: [ :me | me model general name ] write: [ :me :newValue |  ]);
		label: 'General';
		priority: 1;
		yourself
]

{ #category : #forms }
OPUmlGeneralizationController >> descriptionGeneralizationSet [
	<magritteDescription>
	^ MAToManyRelationDescription new
		initializer: [ :desc | 
			desc
				controller: self;
				set: OPUMLGeneralizationSet new ];
		display: [ :desc | 
			String
				streamContents: [ :stream | 
					stream
						<< 'GeneralizationSet {''';
						<< (desc set name ifNil: [ '' ]);
						<< ''', '.
					desc set isCovering
						ifTrue: [ stream << 'complete, ' ]
						ifFalse: [ stream << 'incomplete, ' ].
					desc set isDisjoint
						ifTrue: [ stream << 'disjoint, ' ]
						ifFalse: [ stream << 'overlapping, ' ].
					stream << ('(' , desc set generalizations size asString , ')}') ] ];
		accessor:
			(MAPluggableAccessor
				read: [ :me | 
					me model generalizationSets
						collect: [ :each | 
							OPUmlGeneralizationSetDescriptions new
								controller: self;
								set: each ] ]
				write: [ :me :newValue | 
					me model generalizationSets: (newValue collect: #set).
					diagramElement ifNotNil: [ self refreshFigure ] ]);
		classes: {OPUmlGeneralizationSetDescriptions};
		label: 'Generalization Sets';
		priority: 5;
		yourself
]

{ #category : #forms }
OPUmlGeneralizationController >> descriptionName [
	^ nil
]

{ #category : #forms }
OPUmlGeneralizationController >> descriptionSpecific [
	<magritteDescription>
	^ MAStringDescription new
		beReadonly;
		accessor:
			(MAPluggableAccessor read: [ :me | me model specific name ] write: [ :me :newValue |  ]);
		label: 'Specific';
		priority: 2;
		yourself
]

{ #category : #forms }
OPUmlGeneralizationController >> descriptionVisibility [
	^ nil
]

{ #category : #accessing }
OPUmlGeneralizationController >> modelClass [
	^ OPUMLGeneralization
]

{ #category : #figures }
OPUmlGeneralizationController >> refreshFigure [
	self diagramElement changed
]

{ #category : #removing }
OPUmlGeneralizationController >> removeModel [
	self remove.
	model general: nil.
	model specific: nil.
	model generalizationSets asArray do: [ :each | each generalizations remove: model ]
]

{ #category : #figures }
OPUmlGeneralizationController >> renderFigureIn: aView [
	| sourceElement |
	diagramElement := self createDiagramElement.
	sourceElement := ((diagramController controllers
		select: [ :each | each isKindOf: OPUmlClassController ])
		detect: [ :each | each model generalizations includes: self model ]) diagramElement.
	"	diagramElement source: (diagramController diagramElementForModel: self model specific)."
	diagramElement source: sourceElement.
	diagramElement target: (diagramController diagramElementForModel: self model general).
	diagramElement renderIn: aView.
	diagramController figureAdded: self figure.
	self refreshFigure
]
