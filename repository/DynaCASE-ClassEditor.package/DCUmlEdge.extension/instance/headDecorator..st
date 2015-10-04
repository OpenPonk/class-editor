*DynaCASE-ClassEditor-Accessing
headDecorator: aDecorator
	headDecorator := aDecorator.
	rtEdge ifNotNil: [ rtEdge shape head: aDecorator asHead ]