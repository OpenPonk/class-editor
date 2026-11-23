"
Unit tests for UML package import view models, covering endpoint resolution, display formatting, dependency reporting, and model removal.
"
Class {
	#name : 'OPUmlPackageImportViewModelTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-ClassEditor-Tests-ViewModels',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'ViewModels'
}

{ #category : 'tests' }
OPUmlPackageImportViewModelTest >> testBasicRemoveModelRemovesFromImportingNamespace [

	| testProject sourcePackage targetPackage packageImport testRegistry importViewModel |
	testProject := OPProject new.
	sourcePackage := OPUMLPackage new name: 'Source'.
	targetPackage := OPUMLPackage new name: 'Target'.
	sourcePackage packagedElements add: targetPackage.
	packageImport := OPUMLPackageImport new
		                 importingNamespace: sourcePackage;
		                 importedPackage: targetPackage;
		                 yourself.
	testProject addModel: sourcePackage.
	testRegistry := OPViewModelRegistry forProject: testProject.
	importViewModel := testRegistry viewModelFor: packageImport.

	importViewModel removeModel.
	self assertEmpty: sourcePackage packageImports
]

{ #category : 'tests' }
OPUmlPackageImportViewModelTest >> testEndpointsAndDependingOnElements [

	| testProject sourcePackage targetPackage packageImport testRegistry importViewModel |
	testProject := OPProject new.
	sourcePackage := OPUMLPackage new name: 'Source'.
	targetPackage := OPUMLPackage new name: 'Target'.
	sourcePackage packagedElements add: targetPackage.
	packageImport := OPUMLPackageImport new
		                 importingNamespace: sourcePackage;
		                 importedPackage: targetPackage;
		                 yourself.
	testProject addModel: sourcePackage.
	testRegistry := OPViewModelRegistry forProject: testProject.
	importViewModel := testRegistry viewModelFor: packageImport.

	self assert: importViewModel modelSource identicalTo: sourcePackage.
	self assert: importViewModel modelTarget identicalTo: targetPackage.
	self assertCollection: importViewModel dependingOnElements includesAll: {
			targetPackage.
			sourcePackage }
]

{ #category : 'tests' }
OPUmlPackageImportViewModelTest >> testModelDisplayStringWithNamedAndNilPackages [

	| namedImport emptyImport namedDisplay emptyDisplay |
	namedImport := OPUMLPackageImport new
		               importedPackage: (OPUMLPackage new
				                name: 'Target';
				                yourself);
		               importingNamespace: (OPUMLPackage new
				                name: 'Source';
				                yourself);
		               yourself.
	namedDisplay := String streamContents: [ :stream |
		                (OPUmlPackageImportViewModel new model: namedImport) modelDisplayStringOn: stream ].
	self assert: namedDisplay equals: 'Target --> Source (PackageImport)'.

	emptyImport := OPUMLPackageImport new.
	emptyDisplay := String streamContents: [ :stream |
		                (OPUmlPackageImportViewModel new model: emptyImport) modelDisplayStringOn: stream ].
	self assert: emptyDisplay equals: '? --> ? (PackageImport)'
]

{ #category : 'tests' }
OPUmlPackageImportViewModelTest >> testModelDisplayStringWithUnnamedPackages [

	| packageImport importViewModel displayString |
	packageImport := OPUMLPackageImport new
		                 importedPackage: OPUMLPackage new;
		                 importingNamespace: OPUMLPackage new;
		                 yourself.
	importViewModel := OPUmlPackageImportViewModel new model: packageImport.

	displayString := String streamContents: [ :stream | importViewModel modelDisplayStringOn: stream ].
	self assert: displayString equals: '? --> ? (PackageImport)'
]
