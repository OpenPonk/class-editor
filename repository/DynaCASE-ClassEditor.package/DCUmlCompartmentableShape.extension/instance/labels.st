*DynaCASE-ClassEditor-Accessing
labels
	^ (self ownedElements select: [ :each | each isKindOf: DCUmlLabel ]) asGroup