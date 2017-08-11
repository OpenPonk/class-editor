initialization
initialize
	super initialize.
	(nameLabel := OPUmlNameLabel new)
		text: [ :model | 
			(model isDerived
				ifTrue: [ '/' ]
				ifFalse: [ '' ]) , (model name ifNil: [ '' ]) ];
		owningElement: self.
	(stereotypeLabel := OPUmlNameLabel new)
		text: [ :model | 
			model appliedStereotypes
				ifEmpty: [ '' ]
				ifNotEmpty: [ :s | '«' , ((s collect: #name) joinUsing: ',') , '»' ] ];
		owningElement: self.
	sourceEndLabels := OPUmlAssociationEndLabels on: self.
	targetEndLabels := OPUmlAssociationEndLabels on: self.
	constraints := OrderedCollection new