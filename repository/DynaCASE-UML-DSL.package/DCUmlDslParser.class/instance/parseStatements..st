parsing
parseStatements: aString
	^ DCUmlDslBuilder new parse: (self normalize: aString)