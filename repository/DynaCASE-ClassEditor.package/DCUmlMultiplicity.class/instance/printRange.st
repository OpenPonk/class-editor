printing
printRange
	^ String
		streamContents:
			[ :stream | 
			stream
				nextPut: $[;
				nextPutAll: self lowerAsString.
			self lower = self upper
				ifFalse: [ 
					stream
						nextPutAll: '..';
						nextPutAll: self upperAsString ].
			stream nextPut: $] ]