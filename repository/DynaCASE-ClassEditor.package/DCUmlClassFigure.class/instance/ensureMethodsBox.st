accessing - figures
ensureMethodsBox
	methodsBox
		ifNil: [ 
			methodsBox := self newCompartment.
			self addLast: methodsBox ].
	^ methodsBox