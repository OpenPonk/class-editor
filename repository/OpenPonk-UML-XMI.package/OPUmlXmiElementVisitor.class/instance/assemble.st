converting
assemble
	elements
		keysAndValuesDo: [ :key :value | 
			value isBlock
				ifTrue: [ elements at: key put: value value ] ]