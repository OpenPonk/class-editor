ui hooks
buildStereotypeEditorForm: aForm
	| stereotypes repeat |
	repeat := [ :str :num | String withAll: ((1 to: num) flatCollect: [ :i | str ]) ].
	stereotypes := OrderedCollection with: 'CormasModel' -> 0 with: 'CormasEntity' -> 0.
	CormasEntity
		allSubclassesWithLevelDo: [ :cls :level | stereotypes add: cls name asString -> level ]
		startingLevel: 1.
	(aForm addDroplist: 'Stereotype')
		items: stereotypes;
		displayBlock: [ :pair | (repeat value: '    ' value: pair value) , pair key ];
		setSelectedItem:
			(self model stereotypes
				ifEmpty: [ nil ]
				ifNotEmpty: [ :s | stereotypes detect: [ :pair | pair key = s first name ] ]);
		whenSelectedItemChanged: [ :newValue | 
			| kw |
			kw := {newValue key}.
			kw size - self model stereotypes size
				timesRepeat: [ self model addStereotype: DCFAMIXStereotype new ].
			self model stereotypes size - kw size
				timesRepeat: [ self model stereotypes removeLast ].
			kw doWithIndex: [ :each :i | (self model stereotypes at: i) name: each ].
			self refreshFigure ]