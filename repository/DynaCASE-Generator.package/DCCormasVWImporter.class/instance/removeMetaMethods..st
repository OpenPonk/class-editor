as yet unclassified
removeMetaMethods: aClass
	aClass methods
		detect: [ :each | each name = 'isAbstract' & each isStatic ]
		ifFound: [ :each | 
			aClass isAbstract: each sourceAnchor pharoEntity methodClass theNonMetaClass isAbstract.
			self removeMethod: each ]