Class {
	#name : #CormasUmlClassController,
	#superclass : #Object,
	#category : 'UMLClassEditor-Cormas-Controllers'
}

{ #category : #accessing }
CormasUmlClassController >> addAutomaticCormasAssociation [
	| sourceClass tool paletteModel |
	sourceClass := self diagramController model allClasses
		detect:
			[ :each | each stereotypes isNotEmpty and: [ each stereotypes first name = 'CormasModel' ] ]
		ifFound: #yourself
		ifNone: [ ^ self ].
	paletteModel := self diagramController editor paletteModel.
	(tool := OPConnectionCreationTool new)
		palette: paletteModel;
		factory: [ OPUmlAssociationController new ].
	paletteModel selectTool: tool.
	tool sourceSelected: (self diagramController controllerForModel: sourceClass).
	tool
		whenCompleted: [ :ctrl | 
			ctrl model targetEnd
				name: 'the' , self model name , 's';
				multiplicity: OPFAMIXMultiplicity zeroToMany.
			ctrl refreshFigure ].
	tool targetSelected: self.
	paletteModel selectedTool targetSelected: self
]

{ #category : #'as yet unclassified' }
CormasUmlClassController >> buildAbstractEditorForm: aForm [
	(aForm addCheckbox: 'Is Abstract')
		state: self model isAbstract;
		whenChangedDo: [ :val | 
			self model isAbstract: val.
			self diagramController model isCormasModel
				ifTrue: [ self model isAbstract
						ifTrue: [ self removeAutomaticCormasAssociation ]
						ifFalse: [ self addAutomaticCormasAssociation ] ].
			self refreshFigure ]
]

{ #category : #'as yet unclassified' }
CormasUmlClassController >> buildStereotypeEditorForm: aForm [
	| repeat stereotypes |
	repeat := [ :str :num | String withAll: ((1 to: num) flatCollect: [ :i | str ]) ].
	stereotypes := self cormasStereotypes , (Array with: 'enumeration' -> 0 with: 'primitive' -> 0 with: 'dataType' -> 0).
	(aForm addDroplist: 'Stereotype')
		items: stereotypes;
		displayBlock: [ :pair | (repeat value: '    ' value: pair value) , pair key ];
		setSelectedItem: (self model stereotypes ifEmpty: [ nil ] ifNotEmpty: [ :s | stereotypes detect: [ :pair | pair key = s first name ] ]);
		whenSelectedItemChanged: [ :newValue | 
			| kw |
			kw := Array with: newValue key.
			kw size - self model stereotypes size timesRepeat: [ self model addStereotype: OPFAMIXStereotype new ].
			self model stereotypes size - kw size timesRepeat: [ self model stereotypes removeLast ].
			kw doWithIndex: [ :each :i | (self model stereotypes at: i) name: each ].
			self refreshFigure ]
]

{ #category : #accessing }
CormasUmlClassController >> cormasStereotypes [
	| cls dict depth |
	"((CormasNS.Kernel.Entity withAllSubclasses
		select: [ :each | each environment = CormasNS.Kernel ])
		collect: [ :each | Array with: each superclass name with: each name ]) asArray."
	cls := #(#(Object Entity) #(Entity SpatialEntity) #(Entity Agent) #(Entity PassiveObject) #(SpatialEntity SpatialEntityElement) #(SpatialEntity SpatialEntitySet) #(SpatialEntityElement SpatialEntityCell) #(SpatialEntitySet SpatialEntityAggregate) #(SpatialEntitySet SpatialEntityNotConnex) #(Agent AgentComm) #(Agent AgentLocation) #(Agent Group) #(AgentComm GroupComm) #(AgentLocation GroupLocation) #(AgentLocation AgentCommLocation) #(AgentCommLocation GroupCommLocation) #(PassiveObject ObjectLocation) #(PassiveObject NetworkEntity) #(ObjectLocation NetworkComponentEntity) #(NetworkComponentEntity ArcEntity) #(NetworkComponentEntity NodeEntity)).
	dict := (cls collect: [ :each | each second -> each first ]) asDictionary.
	depth := nil.
	depth := [ :key | dict at: key ifPresent: [ :val | 1 + (depth value: val) ] ifAbsent: [ -1 ] ].
	^ {#CormasModel -> 0} , (dict keys collect: [ :each | each -> (depth value: each) ])
		sorted: [ :a :b | a value < b value or: [ a value = b value & (a key < b key) ] ]
]

{ #category : #'as yet unclassified' }
CormasUmlClassController >> removeAutomaticCormasAssociation [
	| sourceClass |
	sourceClass := self diagramController model allClasses
		detect:
			[ :each | each stereotypes isNotEmpty and: [ each stereotypes first name = 'CormasModel' ] ]
		ifFound: #yourself
		ifNone: [ ^ self ].
	(self model incomingAssociations
		select:
			[ :each | each source = sourceClass and: [ each targetEnd name = ('the' , self model name , 's') ] ])
		do: [ :each | self diagramController removeFromModel: each ]
]
