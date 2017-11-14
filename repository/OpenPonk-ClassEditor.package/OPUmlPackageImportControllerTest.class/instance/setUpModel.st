running
setUpModel
	importingNamespace := OPUMLPackage new name: 'Importing Namespace'.
	importedPackage := OPUMLPackage new name: 'Imported Package'.
	packageImport := OPUMLPackageImport new
		importingNamespace: importingNamespace;
		importedPackage: importedPackage