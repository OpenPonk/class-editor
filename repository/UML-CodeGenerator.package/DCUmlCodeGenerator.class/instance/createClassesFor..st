generator - class
createClassesFor: aCollection
	"Super must be created before subclasses."

	^ (aCollection asSortedCollection: [ :a :b | a superclassHierarchy includes: b ]) reversed
		collect: [ :each | self createFullClassFor: each ]