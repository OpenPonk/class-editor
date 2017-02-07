as yet unclassified
addLazyValueFor: anAttribute in: aClass
	| expression source |
	expression := self defaultValueExpressionFor: anAttribute.
	expression ifNil: [ ^ self ].
	source := OPUmlSingleOpaqueBehavior
		body:
			('{name}
	^ {name} ifNil: [ {name} := {value} ]'
				format:
					(Dictionary with: #name -> anAttribute name with: #value -> expression)).
	aClass methods
		detect: [ :each | each name = anAttribute name ]
		ifFound: [ :m | m sourceAnchor: source ]
		ifNone: [ aClass
				addMethod:
					(FAMIXMethod new
						name: anAttribute name;
						protocol: 'accessing';
						sourceAnchor: source) ]