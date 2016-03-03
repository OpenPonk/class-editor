printing
mooseNameOn: aStream
	aStream nextPutAll: self name.
	aStream nextPutAll: ' ('.
	self mooseDisplayStringOn: aStream.
	aStream nextPutAll: ')'.