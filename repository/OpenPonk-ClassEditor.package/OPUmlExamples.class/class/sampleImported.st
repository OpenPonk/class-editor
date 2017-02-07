examples
sampleImported
	| model importer |
	model := MooseModel new.
	model name: 'DynaCASE - Imported Model'.
	importer := MoosePharoImporterTask new.
	importer importingContext mergeClassAndMetaclass.
	importer runCandidateOperator.
	importer
		model: model;
		addFromPackageNamed: 'DynaCASE-Model';
		runWithProgress.
	^ model