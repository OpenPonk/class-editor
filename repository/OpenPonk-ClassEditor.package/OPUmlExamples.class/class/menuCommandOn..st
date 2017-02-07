menu
menuCommandOn: aBuilder
	<worldMenu>
	(aBuilder item: #UMLClassEditor)
		icon: OPIcons current dcOmlDiagramIcon;
		label: 'UML Class Diagram';
		parent: #MostUsedTools;
		action: [ self exampleEmpty ];
		with: [ 
					(aBuilder item: #UMLClassEditorExamples)
						parent: #UMLClassEditor;
						label: 'Simple Model';
						icon: OPIcons current dcOmlDiagramIcon;
						action: [ self exampleModel ].
					(aBuilder item: #UMLClassEditorExamples)
						parent: #UMLClassEditor;
						label: 'University';
						icon: OPIcons current dcOmlDiagramIcon;
						action: [ self exampleDsl ]  ]