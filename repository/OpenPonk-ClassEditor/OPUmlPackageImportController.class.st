"
I am a controller for a PackageImport.
"
Class {
	#name : #OPUmlPackageImportController,
	#superclass : #OPUmlRelationshipController,
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #figures }
OPUmlPackageImportController >> createDiagramElement [
	^ OPUmlPackageImportShape new
		modelElement: self model;
		yourself
]

{ #category : #figures }
OPUmlPackageImportController >> createModelIn: aParentModel [
	self model: self modelClass new.
	model importedPackage: aParentModel.
	model importingNamespace: source model.
	^ model
]

{ #category : #forms }
OPUmlPackageImportController >> descriptionGeneral [
	"<magritteDescription>
	^ MAStringDescription new
		beReadonly;
		accessor:
			(MAPluggableAccessor read: [ :me | me model general name ] write: [ :me :newValue |  ]);
		label: 'General';
		priority: 1;
		yourself"
]

{ #category : #forms }
OPUmlPackageImportController >> descriptionGeneralizationSet [
"	<magritteDescription>
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
		yourself"
]

{ #category : #forms }
OPUmlPackageImportController >> descriptionName [
	^ nil
]

{ #category : #forms }
OPUmlPackageImportController >> descriptionSpecific [
"	<magritteDescription>
	^ MAStringDescription new
		beReadonly;
		accessor:
			(MAPluggableAccessor read: [ :me | me model specific name ] write: [ :me :newValue |  ]);
		label: 'Specific';
		priority: 2;
		yourself"
]

{ #category : #forms }
OPUmlPackageImportController >> descriptionVisibility [
	^ nil
]

{ #category : #accessing }
OPUmlPackageImportController >> modelClass [
	^ OPUMLPackageImport
]

{ #category : #figures }
OPUmlPackageImportController >> refreshFigure [
	self diagramElement changed
]

{ #category : #removing }
OPUmlPackageImportController >> removeModel [
	model importedPackage: nil.
	model importingNamespace: nil
]

{ #category : #figures }
OPUmlPackageImportController >> renderFigureIn: aView [
	| sourceElement |
	diagramElement := self createDiagramElement.
	sourceElement := ((diagramController controllers
		select: [ :each | each isKindOf: OPUmlPackageController ])
		detect: [ :each | each model packageImports includes: self model ]) diagramElement.
	"	diagramElement source: (diagramController diagramElementForModel: self model specific)."
	diagramElement source: sourceElement.
	diagramElement target: (diagramController diagramElementForModel: self model importedPackage).
	diagramElement renderIn: aView.
	diagramController figureAdded: self figure.
	self refreshFigure
]

{ #category : #construction }
OPUmlPackageImportController >> showInDiagram: aDiagramController [
	aDiagramController showInDiagramModel: model importedPackage.
	aDiagramController showInDiagramModel: model importingNamespace.
	^ super showInDiagram: aDiagramController
]
