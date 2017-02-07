visitor
visitParameter: aParameter
	| attrs |
	self ensureType: aParameter declaredType.
	attrs := Dictionary
		with: #type -> aParameter declaredType uuid asString
		with: #xmi:id -> aParameter uuid asString
		with: #name -> aParameter name
		with: #direction -> (aParameter direction splitOn: '::') last.
	writer
		tag: #ownedParameter
		attributes: attrs
		with: [ self visitMultiplicity: aParameter multiplicity ]