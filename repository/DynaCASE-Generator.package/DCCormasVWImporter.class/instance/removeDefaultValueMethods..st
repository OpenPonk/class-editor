as yet unclassified
removeDefaultValueMethods: aClass
	(aClass methods select: [ :each | each name endsWith: '_default' ])
		do: [ :each | self removeMethod: each from: aClass ]