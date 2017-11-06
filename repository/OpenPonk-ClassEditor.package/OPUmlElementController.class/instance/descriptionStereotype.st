forms
descriptionStereotype
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