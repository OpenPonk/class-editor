menu
menuCommandOn: aBuilder
	<worldMenu>
	(aBuilder item: #DynaUML)
		icon: DCIcons current dcOmlDiagramIcon;
		label: 'UML Class Diagram';
		parent: #MostUsedTools;
		action: [ self exampleEmpty ];
		with: [ 
					(aBuilder item: #DynaUMLExamples)
						parent: #DynaUML;
						label: 'Simple Model';
						icon: DCIcons current dcOmlDiagramIcon;
						action: [ self exampleModel ].
					(aBuilder item: #DynaUMLExamples)
						parent: #DynaUML;
						label: 'University';
						icon: DCIcons current dcOmlDiagramIcon;
						action: [ self exampleDsl ]  ]