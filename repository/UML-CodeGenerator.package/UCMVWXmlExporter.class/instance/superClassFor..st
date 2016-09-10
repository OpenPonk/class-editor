as yet unclassified
superClassFor: aClass
	aClass stereotypes ifEmpty: [ ^ 'Core.Object' ].
	^ 'CormasNS.Kernel.' , aClass stereotypes first name