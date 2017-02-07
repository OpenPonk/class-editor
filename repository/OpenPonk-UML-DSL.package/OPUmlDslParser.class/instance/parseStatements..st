parsing
parseStatements: aString
	^ OPUmlDslBuilder new parse: (self normalize: aString)