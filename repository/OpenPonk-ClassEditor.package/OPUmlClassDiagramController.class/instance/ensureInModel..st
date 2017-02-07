adding
ensureInModel: anEntity
	(self model includes: anEntity)
		ifFalse: [ self model add: anEntity ]