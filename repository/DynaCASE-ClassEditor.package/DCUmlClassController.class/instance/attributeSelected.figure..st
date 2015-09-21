as yet unclassified
attributeSelected: anAttribute figure: aFigure
	| form |
	form := self diagramController editor workbench formModel.
	form editController: nil.
	(form addTextInput: 'Name')
		text: anAttribute name;
		whenTextIsAccepted: [ :newValue | 
			anAttribute name: newValue.
			aFigure changed ].
	(form addTextInput: 'Type')
		text: (anAttribute declaredType ifNil: [ '' ] ifNotNil: [ :t | t name ]);
		whenTextIsAccepted:
				[ :newValue | 
			newValue
				ifEmpty: [ anAttribute declaredType: nil ]
				ifNotEmpty: [ anAttribute declaredType: (FAMIXClass named: newValue) ].
			aFigure changed ].
	(form addCheckbox: 'Class')
		state: anAttribute isStatic;
		whenChangedDo: [ :val | 
			anAttribute isStatic: val.
			aFigure changed ].
	(form addTextInput: 'Multiplicity min')
		text: anAttribute multiplicity printLower;
		whenTextIsAccepted:
				[ :val | 
			val
				ifNotEmpty: [ 
					anAttribute multiplicity lower: val asString.
					aFigure changed ] ].

	(form addTextInput: 'Multiplicity max')
		text: anAttribute multiplicity printUpper;
		whenTextIsAccepted:
				[ :val | 
			val
				ifNotEmpty:
					[ 
					anAttribute multiplicity
						upper:
							(val = '*'
								ifTrue: [ -1 ]
								ifFalse: [ val asNumber ]).
					aFigure changed ] ].

	form rebuildWidget.
	form takeKeyboardFocus