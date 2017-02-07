as yet unclassified
createCollectionAccessorsFor: anEnd in: aClass
	| adder remover |
	adder := self adder: anEnd.
	aClass
		addMethod:
			(FAMIXMethod new
				name: (adder lines first splitOn: ':') first , ':';
				protocol: 'adding/removing';
				sourceAnchor: (OPUmlSingleOpaqueBehavior body: adder)).
	remover := self remover: anEnd.
	aClass
		addMethod:
			(FAMIXMethod new
				name: (remover lines first splitOn: ':') first , ':';
				protocol: 'adding/removing';
				sourceAnchor: (OPUmlSingleOpaqueBehavior body: remover))