*DynaCASE-ClassEditor-Descriptions
descriptionDeclaredType
	<magritteDescription>
	^ MAToOneRelationDescription new
		selectorAccessor: #declaredType;
		label: 'Declared Type';
		classes: {FAMIXClass};
		priority: 20;
		beRequired;
		yourself