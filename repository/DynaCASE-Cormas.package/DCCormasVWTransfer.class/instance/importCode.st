as yet unclassified
importCode
	| stream |
	stream := UIManager default
		fileOpen: 'Select .sif file to extract the package from'
		extensions: #('sif').
	stream ifNil: [ ^ self inform: 'Canceled' ].
	SmalltalkInterchangeFileManager newForFileIn
		fileName: stream name;
		fileIn.
	self inform: 'Imported'