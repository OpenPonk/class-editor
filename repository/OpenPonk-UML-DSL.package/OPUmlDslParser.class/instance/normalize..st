parsing
normalize: aString
	^ (aString trim lines collect: #trim) joinUsing: String cr