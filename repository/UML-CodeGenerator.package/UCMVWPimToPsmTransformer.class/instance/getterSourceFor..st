transforming - accessors
getterSourceFor: anAttribute
	^ (self context shouldUseLazyInitialization and: [ anAttribute defaultValue isNotNil ])
		ifTrue: [ self lazyGetterSourceFor: anAttribute ]
		ifFalse: [ self eagerGetterSourceFor: anAttribute ]