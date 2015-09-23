*DynaCASE-ClassEditor-Descriptions
descriptionAttributes
	<magritteDescription>
	^ MAToManyRelationDescription new
		accessor: #attributes;
		label: 'Attributes';
		classes: {FAMIXAttribute};
		ordered: true;
		priority: 20;
		yourself