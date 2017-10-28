accessing
simpleGeneralization
	<gtExample>
	| cls cls2 model |
	model := self emptyModel.
	model name: 'Simple Generalization'.
	cls := OPUMLClass new name: 'Item'.
	cls2 := OPUMLClass new name: 'Thing'.
	OPUMLGeneralization new
		general: cls2;
		specific: cls.
	model
		packagedElements:
			{cls.
			cls2} asOrderedCollection.
	^ model