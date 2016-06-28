generator - templates
getter: anEnd
	self context shouldUseEagerInitialization
		ifTrue: [ ^ self eagerGetter: anEnd ].
	self context shouldUseLazyInitialization
		ifTrue: [ ^ self lazyGetter: anEnd ]