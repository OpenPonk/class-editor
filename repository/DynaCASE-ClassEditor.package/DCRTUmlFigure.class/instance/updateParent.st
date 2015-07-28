accessing
updateParent
	self parent ifNotNil: [ self parent childChanged ]