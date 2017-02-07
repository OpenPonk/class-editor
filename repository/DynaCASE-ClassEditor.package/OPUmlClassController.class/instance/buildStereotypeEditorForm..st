ui hooks
buildStereotypeEditorForm: aForm
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
			kw size - self model stereotypes size timesRepeat: [ self model addStereotype: DCFAMIXStereotype new ].
			self model stereotypes size - kw size timesRepeat: [ self model stereotypes removeLast ].
			kw doWithIndex: [ :each :i | (self model stereotypes at: i) name: each ].
			self refreshFigure ]