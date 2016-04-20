accessing
literalsFor: anEnum
	"Proper enum literals are not yet supported so I am abusing attributes"

	^ (anEnum attributes collect: [ :each | each name asSymbol -> each name asSymbol printString ]) asDictionary