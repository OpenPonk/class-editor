forms
descriptionIsDerived
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isDerived);
		label: 'Is Derived';
		priority: 8;
		yourself