examples
sampleCompleteClassFamix
	| model class string object number float integer |
	string := FAMIXClass named: 'String'.
	object := FAMIXClass named: 'Object'.
	number := FAMIXClass named: 'Number'.
	float := FAMIXClass named: 'Float'.
	integer := FAMIXClass named: 'Integer'.
	model := MooseModel named: 'Something'.
	class := FAMIXClass named: 'CompleteClass'.
	class isAbstract: true.
	model add: class.
	class addStereotype: (OPFAMIXStereotype named: 'class').
	class addStereotype: (OPFAMIXStereotype named: 'example').
	class stereotypes first
		addIcon:
			(OPFAMIXImage new
				content:
					'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3gwRESYZc+TopwAAABl0RVh0Q29tbWVudABDcmVhdGVkIHdpdGggR0lNUFeBDhcAAABDSURBVDjLY2CgEDBC6f9EqMEL/pMoDgdMlHqBhRTbCPnvP6n+JsvPVA+DgTeAUEJiJBA+jPgk/xPDZ6E0VqjmhYEDAKlHDwzayLTLAAAAAElFTkSu
QmCC').
	class addAttribute: (FAMIXAttribute named: 'normal' type: integer).
	class
		addAttribute:
			((FAMIXAttribute named: 'collection' type: float)
				multiplicity: OPFAMIXMultiplicity zeroToMany).
	class addAttribute: ((FAMIXAttribute named: 'static' type: string) isStatic: true).
	class addAttribute: ((FAMIXAttribute named: 'abstract' type: object) isAbstract: true).
	class addMethod: (FAMIXMethod named: 'basicMethod').
	class
		addMethod:
			((FAMIXMethod named: 'staticMethod')
				addParameter: (FAMIXParameter named: 'number' type: number);
				isStatic: true).
	class
		addMethod:
			((FAMIXMethod named: 'abstractMethod')
				addParameter:
					((FAMIXParameter named: 'return' type: string)
						direction: OPUmlParameterDirectionKind return);
				addParameter: (FAMIXParameter named: 'arg1' type: number);
				addParameter: ((FAMIXParameter named: 'arg2' type: string) multiplicity: OPFAMIXMultiplicity zeroToOne);
				isAbstract: true).
	^ model