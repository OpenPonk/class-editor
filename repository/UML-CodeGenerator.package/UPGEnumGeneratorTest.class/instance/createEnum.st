running
createEnum
	| mooseModel pkg enumModel |
	mooseModel := 'TestEnumKind <<enumeration>> {
	organization
	person
	system
}' asClassDiagram.
	enumModel := mooseModel allModelClasses first.
	(pkg := FAMIXPackage new) name: self categoryName.
	pkg mooseModel: mooseModel.
	enumModel parentPackage: pkg.
	^ enumModel