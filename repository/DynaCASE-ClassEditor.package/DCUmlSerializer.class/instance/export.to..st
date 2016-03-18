import-export
export: aMemento to: aFolder
	aFolder / 'model' , 'txt'
		writeStreamDo: [ :stream | 
			stream
				wantsLineEndConversion: true;
				nextPutAll: (DCUmlDslExporter new export: aMemento model) ].
	aFolder / 'layout' , 'ston'
		writeStreamDo: [ :stream | 
			stream
				wantsLineEndConversion: true;
				nextPutAll: (STON toStringPretty: aMemento layout) ]