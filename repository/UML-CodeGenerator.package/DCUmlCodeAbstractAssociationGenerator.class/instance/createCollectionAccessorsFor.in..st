generator - accessors
createCollectionAccessorsFor: anEnd in: aClass
	aClass compile: (self adder: anEnd) classified: 'adding/removing'.
	aClass compile: (self remover: anEnd) classified: 'adding/removing'