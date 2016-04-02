as yet unclassified
removeAccessors: aClass
	aClass methods copy
		select: [ :each | each isSetter | each isGetter ]
		thenDo: [ :each | self removeMethod: each ]