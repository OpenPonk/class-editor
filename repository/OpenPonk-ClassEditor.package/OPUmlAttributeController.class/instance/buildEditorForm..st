ui hooks
buildEditorForm: aForm
	| provider |
	self buildStereotypeEditorForm: aForm.
	self buildNameEditorForm: aForm.
	provider := OPUmlTypesProvider new.
	provider modelTypes: self diagramController model allTypes.
	(aForm addEntity: 'Type')
		displaySymbol: #name;
		possibleEntities: [ provider allTypes values flatten ];
		entity: self model declaredType;
		whenEntityChanged: [ :e | 
			(e isKindOf: Association)
				ifFalse: [ e name = 'nil'
						ifTrue: [ self model declaredType: nil ]
						ifFalse: [ self model declaredType: e ] ].
			self refreshFigure ];
		selectDialog: [ OPUmlTypeListPresenter new itemsBlock: [ provider allTypes ] ].
	aForm addLabel: 'Default value'.
	(aForm addButton: 'change...')
		action: [ OPUmlAttributeEditor openOn: self model onAccept: [ self refreshFigure ] ].
	self buildIsClassSideEditorForm: aForm.
	(aForm addEditableDroplist: 'Multiplicity')
		items: #('0..1' '1..1' '0..*' '1..*');
		setSelectedItem: self model multiplicity printFullRange;
		whenSelectedItemChanged: [ :val | 
			self model multiplicity: (OPFAMIXMultiplicity fromString: val).
			self refreshFigure ]