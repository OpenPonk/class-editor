as yet unclassified
superClassFor: aClass
	aClass stereotypes
		ifEmpty: [ ^ aClass superclass
				ifNil: [ 'Core.Object' ]
				ifNotNil: [ :sup | environment , '.' , sup name ] ].
	^ 'CormasNS.Kernel.' , aClass stereotypes first name