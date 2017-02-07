cormas - modifications
addAutomaticCormasAssociation
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