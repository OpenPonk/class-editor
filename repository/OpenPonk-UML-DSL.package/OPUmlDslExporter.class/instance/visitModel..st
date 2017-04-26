visitor
visitModel: aModel
	aModel allClasses
		do: [ :each | self visitClass: each ]
		separatedBy: [ self line.
			self line ].
	aModel allInheritanceDefinitions isNotEmpty
		ifTrue: [ self line.
			self line ].
	aModel allInheritanceDefinitions
		do: [ :each | self visitInheritance: each ]
		separatedBy: [ self line ].
	aModel allBinaryAssociations isNotEmpty
		ifTrue: [ self line.
			self line ].
	aModel allBinaryAssociations
		do: [ :each | self visitAssociation: each ]
		separatedBy: [ self line ]