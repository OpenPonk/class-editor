printing
printOn: aStream
	aStream
		nextPutAll: self class name;
		nextPut: $[;
		nextPutAll: self lower asString;
		nextPutAll: '..';
		nextPutAll:
			(self upper isInfinite
				ifTrue: [ '*' ]
				ifFalse: [ self upper asString ]);
		nextPut: $]