*OpenPonk-ClassEditor-Descriptions
descriptionMultiplicity
	<magritteDescription>
	^ MAToOneRelationDescription new
		selectorAccessor: #multiplicity;
		label: 'Multiplicity';
		classes: {OPFAMIXMultiplicity};
		priority: 20;
		yourself