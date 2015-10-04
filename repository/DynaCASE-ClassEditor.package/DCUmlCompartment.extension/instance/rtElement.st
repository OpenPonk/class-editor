*DynaCASE-ClassEditor-Manipulation
rtElement
	^ rtElement ifNil: [ rtElement := self createRtElement ]