parsing
parseStatements: aString into: aModel
	self replaceModel: aModel withStatements: (self parseStatements: aString)