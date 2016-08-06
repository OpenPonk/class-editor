accessing
allTypes
	^ (OrderedDictionary
		with: #primitives -> self primitiveTypes
		with: #collections -> self collectionTypes
		with: #model -> self modelTypes)
		,
			(self profileTypes
				ifEmpty: [ #() ]
				ifNotEmpty: [ OrderedDictionary with: #profile -> self profileTypes ])