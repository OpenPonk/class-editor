*DynaCASE-ClassEditor-Accessing
rtElement
	^ rtElement ifNil: [ rtElement := self createRtElement ]