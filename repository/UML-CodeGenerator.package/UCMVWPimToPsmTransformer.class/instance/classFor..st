transforming
classFor: aClass
	| copyClass |
	copyClass := self entityFor: aClass.
	aClass stereotypes do: [ :each | copyClass addStereotype: (self entityFor: each) ].
	aClass isAbstract
		ifTrue: [ copyClass addMethod: (self isAbstractMethodFor: aClass) ].
	aClass attributes
		do: [ :each | 
			| copy |
			copy := self attributeFor: each.
			copyClass addAttribute: copy.
			(self accessorsFor: each) do: [ :meth | copyClass addMethod: meth ].
			(self metaForAttributeFor: each) do: [ :meth | copyClass addMethod: meth ] ].
	aClass methods
		do: [ :each | 
			| copy |
			copy := self methodFor: each.
			copyClass addMethod: copy ].
	^ copyClass