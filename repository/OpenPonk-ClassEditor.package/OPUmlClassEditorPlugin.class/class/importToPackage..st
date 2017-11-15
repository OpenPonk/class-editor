toolbar
importToPackage: aPackage
	FDOpenFileDialog new
		whenSelected: [ :file | |model|
			model := OPUMLXMIReader read: file contents.
			self inform: 'Imported from ' , file fullName ];
		extensionFilters:
			{'XMI files' -> #(xmi xml uml).
			'All files' -> #()};
		defaultFolder: FileLocator imageDirectory asFileReference;
		open