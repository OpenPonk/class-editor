accessing
richClass
	<gtExample>
	| class stateMachine comment enum |
	class := OPUMLClass new name: 'CompleteClass'.
	class isAbstract: true.
	#('Boolean' 'Integer' 'Real' 'String' 'UnlimitedNatural')
		do: [ :each | 
			| type |
			type := OPUMLXMISpecsStorage primitiveTypeNamed: each.
			class ownedAttributes
				add:
					(OPUMLProperty new
						name: 'primitive' , each;
						type: type) ].
	comment := OPUMLXMISpecsStorage metaClassNamed: 'Comment'.
	stateMachine := OPUMLXMISpecsStorage metaClassNamed: 'StateMachine'.
	class ownedAttributes
		add:
			(OPUMLProperty new
				name: 'derived';
				isDerived: true).
	class ownedAttributes
		add:
			(OPUMLProperty new
				name: 'comments';
				type: comment;
				lowerValue: (OPUMLLiteralInteger new value: 0);
				upperValue: (OPUMLLiteralUnlimitedNatural new value: '*')).
	class ownedAttributes
		add:
			(OPUMLProperty new
				name: 'static';
				type: stateMachine;
				isStatic: true).
	class ownedOperations add: (OPUMLOperation new name: 'basicMethod').
	enum := (OPUMLXMISpecsStorage umlMetamodel packagedElements
		flatCollect: #packagedElements) detect: [ :each | each name = 'VisibilityKind' ].
	"	class ownedOperations
		add:
			((OPUMLOperation new name: 'staticMethod')
				in: [ :op | 
					op ownedParameters
						add:
							(OPUMLParameter new
								name: 'enum';
								type: enum) ];
				isStatic: true)."
	class ownedOperations
		add:
			((OPUMLOperation new name: 'abstractMethod')
				in: [ :op | 
					op ownedParameters
						add:
							(OPUMLParameter new
								name: 'return';
								type: (OPUMLXMISpecsStorage primitiveTypeNamed: 'String');
								direction: OPUMLParameterDirectionKind return);
						add:
							(OPUMLParameter new
								name: 'arg1';
								type: (OPUMLXMISpecsStorage primitiveTypeNamed: 'Integer'));
						add:
							(OPUMLParameter new
								name: 'arg2';
								type: stateMachine;
								lowerValue: (OPUMLLiteralInteger new value: 0);
								upperValue: (OPUMLLiteralUnlimitedNatural new value: 1)) ];
				isAbstract: true).
	^ class