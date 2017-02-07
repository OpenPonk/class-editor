*OpenPonk-ClassEditor-Accessing
headDecorator: aDecorator
	headDecorator := aDecorator.
	rtEdge ifNotNil: [ rtEdge shape head: (aDecorator asHead size: 8) ]