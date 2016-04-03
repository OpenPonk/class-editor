as yet unclassified
mergeAttribute: anAttribute in: aClass
	(Array with: anAttribute name with: anAttribute name , ':')
		do: [ :name | 
			aClass methods
				detect: [ :each | each name = name & (each isStatic = anAttribute isStatic) ]
				ifFound: [ :method | self removeMethod: method from: aClass ] ]