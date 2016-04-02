as yet unclassified
removeDefaultValueMethods: aClass
	aClass methods
		select: [ :each | each name endsWith: '_default' ]
		thenDo: [ :each | self removeMethod: each ]