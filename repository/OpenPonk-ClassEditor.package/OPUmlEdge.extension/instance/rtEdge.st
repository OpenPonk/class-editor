*OpenPonk-ClassEditor-Accessing
rtEdge
	^ rtEdge ifNil: [ rtEdge := self createRtEdge ]