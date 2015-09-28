accessing
target: aType
	target := FMMultivalueLink
		on: self
		update: #incomingAssociations
		from: self target
		to: aType