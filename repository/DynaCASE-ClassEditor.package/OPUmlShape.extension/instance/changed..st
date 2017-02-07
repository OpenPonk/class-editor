*DynaCASE-ClassEditor-Updating
changed: aParameter
	self owningElement
		ifNil: [ self update: aParameter ]
		ifNotNil: [ self owningElement changed: aParameter ]