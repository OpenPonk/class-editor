as yet unclassified
exportCode
	| file |
	file := UIManager default
		fileSave: 'Select .sif file to store the package to'
		extensions: #('sif').
	file ifNil: [ ^ self inform: 'Canceled' ].
	SmalltalkInterchangeFileManager newForFileOut
		addPackageNamed: packageDropList selectedItem;
		fileName: file;
		fileOut.
	self inform: 'Exported'