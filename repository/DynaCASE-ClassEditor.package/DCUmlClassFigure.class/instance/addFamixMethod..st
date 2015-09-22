*DynaCASE-ClassEditor-FAMIX
addFamixMethod: aMethod
	self ensureMethodsBox newLabel: [ :label | label famixMethod: aMethod ].
	^ self methodsBox figures last