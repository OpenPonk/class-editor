accessing - figures
ensureAttributesBox
	attributesBox
		ifNil: [ 
			attributesBox := self newCompartment.
			self add: attributesBox afterIndex: 1 ].
	^ attributesBox