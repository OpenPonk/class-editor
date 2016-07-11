as yet unclassified
setterOneToMany: aValue
	setter := FMMultivalueLink
		on: self
		update: #opposites
		from: setter
		to: aValue