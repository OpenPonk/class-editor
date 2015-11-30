generator - model
generateWithProgressBar: aModel
	'Generating...'
		displayProgressFrom: 0
		to: aModel allClasses size + aModel allBinaryAssociations size
		during:
			[ :bar | 
			(aModel allClasses
				sorted: [ :a :b | (b superInheritances collect: #superclass) includes: a ])
				do:
					[ :each | 
					self logCr: each name.
					bar title: 'Generating class ' , each name.
					self createFullClassFor: each.
					bar increment ].
			aModel allBinaryAssociations
				do:
					[ :each | 
					bar title: 'Generating association ' , each asString.
					self createAssociationFor: each.
					bar increment ] ].