instance creation
current
	^ Current ifNil: [ Current := super new ]