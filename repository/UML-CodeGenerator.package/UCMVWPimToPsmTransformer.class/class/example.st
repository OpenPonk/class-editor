example
example
	| pim psm |
	pim := 'VegetationUnit {
	biomass : Integer = 0
}' asClassDiagram.
	pim name: 'Model'.
	pim allClasses first attributes first unit: 'kg'.
	pim allClasses first name: 'VegetationUnit (PIM)'.
	psm := UCMVWPimToPsmTransformer new generateFor: pim with: nil.
	psm allClasses first name: 'VegetationUnit (PSM)'.
	psm add: pim allClasses first.
	DCProject new
		addModel: psm;
		addModel: pim;
		open