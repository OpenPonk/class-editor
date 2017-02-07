accessing
displayFor: anObject
	^ ((self mappingFor: anObject in: self retrieveDisplayMapping)
		ifNil: [ 'Unknown Name' ]
		ifNotNil: [ :name | name ]) , (self suffixFor: anObject)