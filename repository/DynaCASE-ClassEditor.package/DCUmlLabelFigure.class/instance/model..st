accessing
model: anObject
	super model: anObject.
	element model: anObject.
	element attributeAt: #Figure put: self.
	self changed