as yet unclassified
createGetterFor: anAssociationEnd in: aClass
	| source |
	source := self getter: anAssociationEnd.
	aClass
		addMethod:
			(FAMIXMethod new
				name: source lines first;
				protocol: 'accessing';
				sourceAnchor: (OPUmlSingleOpaqueBehavior body: source))