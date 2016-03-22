visitor
visit: anElement
	| methodName |
	methodName := self visitNameFor: anElement name.
	self perform: methodName with: anElement