*DynaCASE-ClassEditor-Accessing
tailDecorator: aDecorator
	tailDecorator := aDecorator.
	rtEdge ifNotNil: [ rtEdge shape tail: (aDecorator asTail size: 8) ]