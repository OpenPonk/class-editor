visitor
visitInheritance: anInheritance
	stream nextPutAll: anInheritance subclass name.
	stream nextPutAll: ' >> '.
	stream nextPutAll: anInheritance superclass name.
	stream nextPut: $;