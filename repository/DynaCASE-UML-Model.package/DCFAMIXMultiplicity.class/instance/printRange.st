printing
printRange
	^ String
		streamContents:
			[ :stream | 
			stream nextPut: $[.
			stream nextPutAll: self printLower.
			self lower = self upper
				ifFalse: [ 
					stream
						nextPutAll: '..';
						nextPutAll: self printUpper ].
			stream nextPut: $] ]