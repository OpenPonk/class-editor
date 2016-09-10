as yet unclassified
writeForgetMethod
	writer
		tag: 'methods'
		with: [ writer
				tag: 'class-id' with: 'CormasNS.Kernel.Entity';
				tag: 'category' with: '-accessing'.
			writer
				tag: 'body'
				attributes: (Dictionary with: #package -> 'Cormas' with: 'selector' -> 'forgetAttribute:')
				with:
					'forgetAttribute: aSymbol
	self instVarAt: (self class instVarIndexFor: aSymbol) put: nil' ]