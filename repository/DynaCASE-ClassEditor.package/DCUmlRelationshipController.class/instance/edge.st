accessing
edge
	^ edge ifNil: [ edge := self createEdge ]