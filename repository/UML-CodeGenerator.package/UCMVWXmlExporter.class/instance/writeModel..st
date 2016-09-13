as yet unclassified
writeModel: aModel
	aModel
		detect:
			[ :each | each stereotypes isNotEmpty and: [ each stereotypes first name = 'CormasModel' ] ]
		ifFound: [ :each | packageName := each name ].
	environment := namespaceEnvironment , '.' , packageName.
	writer := XMLWriter new.
	writer
		writeWith: [ :w | 
			writer
				enablePrettyPrinting;
				xml;
				comment: 'Generated from Pharo.'.
			writer
				tag: 'st-source'
				with: [ self writeMetadata.
					self writeClassesIn: aModel.
					self writeForgetMethod.
					self writeMethodsIn: aModel ] ].
	^ writer contents