*DynaCASE-ClassEditor-Descriptions
descriptionParameters
	<magritteDescription>
	^ MAToManyRelationDescription new
		accessor:
			(MAPluggableAccessor
				read: #parameters
				write: [ :model :newValue | model parameters: newValue asArray copy ]);
		label: 'Parameters';
		classes: {FAMIXParameter};
		ordered: true;
		priority: 20;
		yourself