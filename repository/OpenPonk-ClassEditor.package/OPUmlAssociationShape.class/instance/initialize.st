initialization
initialize
	super initialize.
	(nameLabel := OPUmlNameLabel new)
		text: [ :model | 
			(model isDerived
				ifTrue: [ '/' ]
				ifFalse: [ '' ]) , (model name ifNil: [ '' ]) ];
		owningElement: self.
	(propertiesLabel := OPUmlLabel new)
		text: [ :model | 
			(self propertiesOfModel: model)
				ifEmpty: [ '' ]
				ifNotEmpty: [ :props | '{' , (props joinUsing: ',') , '}' ] ];
		owningElement: self.
	(stereotypeLabel := OPUmlNameLabel new)
		text: [ :model | 
			model appliedStereotypes
				ifEmpty: [ '' ]
				ifNotEmpty: [ :s | '«' , ((s collect: #umlClassName) joinUsing: ',') , '»' ] ];
		owningElement: self.
	sourceEndLabels := self endLabelsClass on: self.
	targetEndLabels := self endLabelsClass on: self.
	constraints := OrderedCollection new