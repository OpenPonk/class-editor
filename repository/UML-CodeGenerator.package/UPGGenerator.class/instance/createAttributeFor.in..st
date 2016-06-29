generator - attribute
createAttributeFor: anAttribute in: aClass
	| cls |
	cls := aClass.
	anAttribute isStatic
		ifTrue: [ cls := cls class ].
	(self ensureInstVariable: anAttribute name in: cls) & self context shouldAddAccessors
		ifTrue: [ self createAccessorsFor: anAttribute in: cls ].
	self context shouldUseEagerInitialization
		ifTrue: [ self addEagerValueFor: anAttribute in: cls ].
	self context shouldUseLazyInitialization
		ifTrue: [ self addLazyValueFor: anAttribute in: cls ]