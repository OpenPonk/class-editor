examples
exampleCommonStructure
	| uml cs |
	uml := OPUMLMetaElement umlMetamodel.
	cs := uml packagedElements detect: [ :each | each name = 'CommonStructure' ].
	^ OPProject new
		name: 'Project';
		addModel: cs;
		open