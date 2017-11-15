accessing
simpleAssociation
	<gtExample>
	| element ownedComment comment owningElement assoc model |
	model := self emptyModel.
	model name: 'Simple Association'.
	element := OPUMLClass new name: 'Element'.
	comment := OPUMLClass new name: 'Comment'.
	assoc := OPUMLAssociation new.
	(ownedComment := OPUMLProperty new)
		name: 'ownedComment';
		lowerValue: (OPUMLLiteralInteger new value: 0);
		upperValue: (OPUMLLiteralUnlimitedNatural new value: '*');
		aggregation: OPUMLAggregationKind composite;
		owningClass: element;
		type: comment.
	(owningElement := OPUMLProperty new)
		name: 'owningElement';
		owningAssociation: assoc;
		type: element.
	assoc
		name: 'comments';
		memberEnds:
			{ownedComment.
			owningElement} asOrderedCollection.
	model
		packagedElements:
			{element.
			comment.
			assoc} asOrderedCollection.
	self useNiceIds: model.
	^ model