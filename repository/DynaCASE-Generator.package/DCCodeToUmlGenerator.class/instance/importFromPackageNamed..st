public - importer
importFromPackageNamed: aPackageName
	| model importer |
	model := MooseModel new.
	model name: aPackageName.
	importer := MoosePharoImporterTask new.
	importer importingContext mergeClassAndMetaclass.
	importer runCandidateOperator.
	importer
		model: model;
		addFromPackageNamed: aPackageName;
		runWithProgress.
	self processPragmasFor: model.
	^ model