accessing
ensureMetaMethodsIn: aClass
	| method |
	(aClass hasInstVarNamed: #Default)
		ifFalse: [ aClass addInstVarNamed: #Default ].
	method := 'enum
	"Generated method"

	^ Default ifNil: [ Default := self new ]'.
	1 halt.
	((aClass includesSelector: #meta) and: [ (aClass >> #meta) sourceCode = method ])
		ifFalse: [ aClass compile: method classified: 'accessing' ]