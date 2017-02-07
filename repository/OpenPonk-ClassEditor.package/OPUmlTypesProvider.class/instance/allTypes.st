accessing
allTypes
	^ (OrderedDictionary with: #model -> self modelTypes)
		,
			(self profileTypes
				ifEmpty: [ #() ]
				ifNotEmpty: [ OrderedDictionary with: #profile -> self profileTypes ])
		,
			(OrderedDictionary
				with: #primitives -> self primitiveTypes
				with: #collections -> self collectionTypes)