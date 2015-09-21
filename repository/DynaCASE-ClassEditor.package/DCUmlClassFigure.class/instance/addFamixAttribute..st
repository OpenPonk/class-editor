*DynaCASE-ClassEditor-FAMIX
addFamixAttribute: anAttribute
	self ensureAttributesBox newLabel: [ :label | label famixAttribute: anAttribute ].
	^ self attributesBox figures last