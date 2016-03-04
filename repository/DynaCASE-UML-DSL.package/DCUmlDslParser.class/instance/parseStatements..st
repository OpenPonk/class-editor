parsing
parseStatements: aString
	^ DCUmlDslBuilder new parse: (self normalize: aString) onError: [ :result | 1 halt ]