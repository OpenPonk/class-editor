as yet unclassified
menuCommandOn: aBuilder
	<worldMenu>
	(aBuilder item: #CormasUMLExamples)
		parent: #UMLClassEditor;
		label: 'New Cormas Model';
		icon: DCIcons current dcOmlDiagramIcon;
		action: [ self createNewModel ]