printing
printOn: aStream
	aStream
		nextPutAll: self class name;
		nextPutAll: self printRange