parsing
parse: aString
	^ self replaceModel: MooseModel new withStatements: (self parseStatements: aString)