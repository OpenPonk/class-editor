*DynaCASE-ClassEditor-Descriptions
descriptionParameters
	<magritteDescription>
	^ MAToManyRelationDescription new
		accessor: #parameters;
		label: 'Parameters';
		classes: {FAMIXParameter};
		ordered: true;
		comment: 'new param?';
		priority: 20;
		yourself