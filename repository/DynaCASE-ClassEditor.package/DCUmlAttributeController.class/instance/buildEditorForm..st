ui hooks
buildEditorForm: aForm
	| provider |
	self buildStereotypeEditorForm: aForm.
	self buildNameEditorForm: aForm.
	provider := DCUmlTypesProvider new.
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
		selectDialog: [ DCUmlTypeListPresenter new itemsBlock: [ provider allTypes ] ].
	aForm addLabel: 'Default value'.
	(aForm addButton: 'change...')
		action: [ DCUmlAttributeEditor openOn: self model onAccept: [ self refreshFigure ] ].
	self buildIsClassSideEditorForm: aForm.
	(aForm addTextInput: 'Multiplicity min')
		text: self model multiplicity printLower;
		whenTextIsAccepted: [ :val | 
			val
				ifNotEmpty: [ self model multiplicity lower: val asString.
					self refreshFigure ] ].
	(aForm addTextInput: 'Multiplicity max')
		text: self model multiplicity printUpper;
		whenTextIsAccepted: [ :val | 
			val
				ifNotEmpty: [ | num |
					num := val = '*'
						ifTrue: [ DCUnlimitedNatural max ]
						ifFalse: [ (NumberParser on: val)
								failBlock: [  ];
								nextNumber ].
					num ifNotNil: [ self model multiplicity upper: num ].
					self refreshFigure ] ]