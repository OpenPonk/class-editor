as yet unclassified
example
| pim psm writer |
pim := '
MyPSM <<CormasModel>> {
}
VegetationUnit <<Entity>> {
	biomass : Integer = 0
}' asClassDiagram.
pim name: 'Model'.
pim allClasses second attributes first unit: 'kg'.

psm := UCMVWPimToPsmTransformer new generateFor: pim with: nil.

writer := UCMVWXmlExporter new.
(writer writeModel: psm).
"
'D:\import.xml.st' asFileReference
	ensureDelete;
	writeStreamDo: [ :str |
		str nextPutAll: (writer writeModel: psm).
	].
"