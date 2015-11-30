generator - method
createMethodFor: aFamixMethod in: aClass
	| name selector |
	self context shouldOverrideMethods not & (aClass selectors includes: aFamixMethod name)
		ifTrue: [ ^ self ].
	name := $: split: aFamixMethod name.
	selector := String new writeStream.
	aFamixMethod parameters size = 0
		ifTrue: [ selector nextPutAll: aFamixMethod name ].
	aFamixMethod parameters
		withIndexDo:
			[ :each :i | 
			selector
				nextPutAll: (name at: i);
				nextPut: $:;
				nextPutAll: each name;
				nextPutAll: ' ' ].
	aClass
		compile:
			('{1}
	{2}
	"not yet implemented"'
				format: (Array with: selector contents with: (self methodPragmaFor: aFamixMethod))).
	(aClass >> aFamixMethod name asSymbol) reformat