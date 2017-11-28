menu
menuCommandOn: aBuilder
	<worldMenu>
	(aBuilder item: #UMLClassEditor)
		icon: OPIcons current openponkIcon;
		label: 'UML Class Diagram Editor';
		parent: #MostUsedTools;
		action: [ self exampleEmptyPackage ];
		with: [ (aBuilder item: #UMLEmptyPackage)
				parent: #UMLClassEditor;
				label: 'New Empty Package';
				icon: OPUmlIcons packageIcon;
				action: [ self exampleEmptyPackage ].
			(aBuilder item: #UMLEmptyModel)
				parent: #UMLClassEditor;
				label: 'New Empty Model';
				icon: OPUmlIcons modelIcon;
				action: [ self exampleEmptyModel ].
			(aBuilder item: #UMLEmptyProfile)
				parent: #UMLClassEditor;
				label: 'New Empty Profile';
				icon: OPUmlIcons profileIcon;
				action: [ self exampleEmptyProfile ];
				withSeparatorAfter.
			(aBuilder item: #UMLCompleteClass)
				parent: #UMLClassEditor;
				label: 'Rich Class';
				icon: OPUmlIcons modelIcon;
				action: [ self exampleRichClass ].
			(aBuilder item: #UMLExampleSimpleAssociation)
				parent: #UMLClassEditor;
				label: 'Simple Association';
				icon: OPUmlIcons modelIcon;
				action: [ self exampleSimpleAssociation ].
			(aBuilder item: #UMLExampleGeneralizationSets)
				parent: #UMLClassEditor;
				label: 'Generalization Sets';
				icon: OPUmlIcons modelIcon;
				withSeparatorAfter;
				action: [ self exampleGeneralizationSets ].
			(aBuilder item: #UMLMetamodelInspect)
				parent: #UMLClassEditor;
				label: 'Inspect UML Metamodel';
				icon: OPUmlIcons packageIcon;
				action: [ OPUMLXMISpecsStorage umlMetamodel inspect ] ]