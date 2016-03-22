visitor
visit: anElement
	| methodName |
	methodName := self visitNameFor: (anElement attributeAt: #xmi:type).
	^ self perform: methodName with: anElement