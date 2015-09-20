accessing
asOptionalString
	"Return string representation if needed ([1] is ignored)"

	^ self printRange = '[1]'
		ifTrue: [ '' ]
		ifFalse: [ self printRange ]