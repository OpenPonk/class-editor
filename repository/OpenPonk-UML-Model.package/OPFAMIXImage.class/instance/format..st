accessing
format: aSymbol
	self assert: [ #PNG = aSymbol ] description: [ 'Format ' , aSymbol , ' is not supported' ].
	format := aSymbol