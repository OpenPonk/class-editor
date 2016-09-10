as yet unclassified
writeModel: aModel
	namespaceEnvironment := 'CormasNS.Models'.
	packageName := 'MyPSM'.
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