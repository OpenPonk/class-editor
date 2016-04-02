as yet unclassified
mergeAttribute: anAttribute
	(Array with: anAttribute name with: anAttribute name , ':')
		do: [ :name | 
			anAttribute parentType methods
				detect: [ :each | each name = name & (each isStatic = anAttribute isStatic) ]
				ifFound: [ :method | self removeMethod: method ] ]