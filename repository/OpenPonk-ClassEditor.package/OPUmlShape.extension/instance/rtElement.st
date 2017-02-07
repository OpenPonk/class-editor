*OpenPonk-ClassEditor-Accessing
rtElement
	^ rtElement ifNil: [ rtElement := self createRtElement ]