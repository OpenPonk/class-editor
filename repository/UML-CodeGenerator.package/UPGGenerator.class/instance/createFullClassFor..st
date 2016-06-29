generator - class
createFullClassFor: aFamixClass
	| cls |
	cls := self createClassFor: aFamixClass.
	aFamixClass attributes do: [ :each | self createAttributeFor: each in: cls ].
	aFamixClass methods do: [ :each | self createMethodFor: each in: cls ].
	^ cls