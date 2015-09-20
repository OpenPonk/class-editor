updating
changed: aParameter
	self parent ifNil: [ self update: aParameter ] ifNotNil: [ self parent changed: aParameter ]