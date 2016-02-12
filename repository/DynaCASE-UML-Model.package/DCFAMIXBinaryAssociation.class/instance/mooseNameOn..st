as yet unclassified
mooseNameOn: aStream
	aStream nextPutAll: self name.
	aStream nextPutAll: ' ('.
	self mooseDisplayStringOn: aStream.
	aStream nextPutAll: ')'.