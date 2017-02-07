visitor
visit: anElement
	| methodName |
	"Ignore XMLString"
	anElement isStringNode
		ifTrue: [ ^ self ].
	methodName := self visitNameFor: anElement name.
	self perform: methodName with: anElement