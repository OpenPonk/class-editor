actions
runGeneratorWith: aDictionary
	(aDictionary at: #targetFile) asFileReference
		ensureDelete;
		writeStreamDo: [ :stream | 
			stream
				nextPutAll: (UCMVWXmlExporter new writeModel: (UCMVWPimToPsmTransformer new generateFor: model with: nil)) ]