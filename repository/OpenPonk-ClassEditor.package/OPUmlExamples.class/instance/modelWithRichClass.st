accessing
modelWithRichClass
	<gtExample>
	| model |
	model := self emptyModel.
	model name: 'Rich Class Model'.
	model packagedElements add: self richClass.
	^ model