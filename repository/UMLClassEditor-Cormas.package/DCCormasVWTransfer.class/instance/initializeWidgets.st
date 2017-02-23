initialization
initializeWidgets
	(packageLabel := self newLabel) label: 'Package'.
	(packageDropList := self newDropList)
		items: (RPackage organizer packages collect: #name as: SortedCollection);
		displayBlock: [ :item | item asString ].
	(importButton := self newButton) label: 'import code from file'.
	(exportButton := self newButton) label: 'export code to file'