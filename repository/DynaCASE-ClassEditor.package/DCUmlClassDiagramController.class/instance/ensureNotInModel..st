removing
ensureNotInModel: anEntity
	(self model includes: anEntity)
		ifTrue: [ self model remove: anEntity ]