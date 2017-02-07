as yet unclassified
createSetterFor: anAssociationEnd in: aClass
	| source |
	source := self setter: anAssociationEnd.
	aClass
		addMethod:
			(FAMIXMethod new
				name: (source lines first splitOn: ':') first , ':';
				protocol: 'accessing';
				sourceAnchor: (OPUmlSingleOpaqueBehavior body: source))