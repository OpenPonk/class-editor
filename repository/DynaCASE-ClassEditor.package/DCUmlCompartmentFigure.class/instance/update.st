updating
update
	super update.
	self parent ifNil: [ ^ self ].
	self align