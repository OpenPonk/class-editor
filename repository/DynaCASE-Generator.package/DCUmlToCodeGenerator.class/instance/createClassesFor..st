generator - class
createClassesFor: aCollection
	"Super must be created before subclasses."

	^ (aCollection sorted: [ :a :b | (b superInheritances collect: #superclass) includes: a ])
		collect: [ :each | self createClassFor: each ]