example
example2
| pim psm wb e1 v1 v2 |
pim := '/VegetationUnit {
	biomass : Integer = 0
}' asClassDiagram.
pim name: 'Model'.
pim allClasses first attributes first unit: 'kg'.

psm := UCMVWPimToPsmTransformer new generateFor: pim with: nil.

(wb := DCWorkbench new) openProject: (DCProject new).

v1 := ((e1 := DCEditor new)
	workbench: wb;
	buildWithSpec;
	openModel: pim) canvasModel roassalView.

v2 := ((e1 := DCEditor new)
	workbench: wb;
	buildWithSpec;
	openModel: psm) canvasModel roassalView.

v1 addAll: v2 elements.
RTGridLayout on: { v1 elements first . v2 elements first }.
v1