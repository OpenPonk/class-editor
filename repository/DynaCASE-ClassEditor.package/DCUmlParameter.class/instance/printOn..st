printing
printOn: aStream
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: self name.
	self type
		ifNotNil:
			[ 
			aStream
				nextPutAll: ' : ';
				nextPutAll: self type;
				nextPut: $[.
			self multiplicity
				ifNil: [ aStream nextPutAll: 'nil' ]
				ifNotNil:
					[ 
					aStream
						nextPutAll: self multiplicity lower asString;
						nextPutAll: '..';
						nextPutAll: self multiplicity upper asString ].
			aStream nextPut: $] ].
	aStream nextPut: $)