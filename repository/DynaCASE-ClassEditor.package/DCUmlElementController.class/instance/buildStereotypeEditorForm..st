ui hooks
buildStereotypeEditorForm: aForm
	(aForm addTextInput: 'Stereotype')
		text:
			(self model stereotypes
				ifEmpty: [ '' ]
				ifNotEmpty: [ :s | (s collect: #name) joinUsing: ',' ]);
		whenTextIsAccepted:
				[ :newValue | 
			| kw |
			kw := ((newValue trim splitOn: ',') removeAllSuchThat: #isEmpty) collect: #trim.
			kw size - self model stereotypes size
				timesRepeat: [ self model addStereotype: DCFAMIXStereotype new ].
			self model stereotypes size - kw size
				timesRepeat: [ self model stereotypes removeLast ].
			kw doWithIndex: [ :each :i | (self model stereotypes at: i) name: each ].
			self refreshFigure ]