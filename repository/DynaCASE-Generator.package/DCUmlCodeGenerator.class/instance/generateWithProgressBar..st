generator - model
generateWithProgressBar: aModel
	'Generating...'
		displayProgressFrom: 0
		to: aModel allModelClasses size + aModel allBinaryAssociations size
		during: [ :bar | 
			(aModel allModelClasses asArray sorted: [ :a :b | b superclassHierarchy includes: a ])
				do: [ :each | 
					self logCr: each name.
					bar title: 'Generating class ' , each name.
					self createFullClassFor: each.
					bar increment ].
			aModel allBinaryAssociations
				do: [ :each | 
					bar title: 'Generating association ' , each asString.
					self createAssociationFor: each.
					bar increment ] ]