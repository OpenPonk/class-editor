accessing
source: aType
	source := FMMultivalueLink
		on: self
		update: #outgoingAssociations
		from: self source
		to: aType