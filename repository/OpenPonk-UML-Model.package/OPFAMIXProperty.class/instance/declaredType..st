accessing
declaredType: aType
	declaredType := FMMultivalueLink
		on: self association
		update:
			(self isSourceEnd
				ifTrue: [ #outgoingAssociations ]
				ifFalse: [ #incomingAssociations ])
		from: self declaredType
		to: aType