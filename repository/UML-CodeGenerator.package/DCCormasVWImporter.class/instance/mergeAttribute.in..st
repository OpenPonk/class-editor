as yet unclassified
mergeAttribute: anAttribute in: aClass
	aClass methods
		detect: [ :each | each name = anAttribute name & (each isStatic = anAttribute isStatic) ]
		ifFound: [ :method | self extractDefaultValueFromAccessor: method ].
	(Array with: anAttribute name with: anAttribute name , ':')
		do: [ :name | 
			aClass methods
				detect: [ :each | each name = name & (each isStatic = anAttribute isStatic) ]
				ifFound: [ :method | self removeMethod: method from: aClass ] ]