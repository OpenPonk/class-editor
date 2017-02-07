accessing
form
	content
		ifNotNil: [ ^ Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: content readStream) ].
	location ifNotNil: [ ^ ImageReadWriter formFromFileNamed: location ].
	self error: 'Neither content nor location has been specified.'