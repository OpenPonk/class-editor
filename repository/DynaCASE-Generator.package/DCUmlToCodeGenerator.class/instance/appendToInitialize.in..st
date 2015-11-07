generator - method
appendToInitialize: aCodeString in: aClass
	self ensureHasInitialize: aClass.
	"Maybe ast addNode: anAssignemntNode?"
	aClass compile: (aClass >> #initialize) sourceCode , '.' , aCodeString.
	(aClass >> #initialize) reformat