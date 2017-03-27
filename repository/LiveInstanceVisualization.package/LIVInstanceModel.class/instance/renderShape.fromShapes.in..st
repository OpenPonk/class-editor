roassal - drawing
renderShape: aShape fromShapes: aCollection in: aView
	(aShape modelElement slots select: [ :each | each value isKindOf: LIVInstanceSpecification ])
		keysAndValuesDo: [ :key :value | 
			aCollection
				detect: [ :each | each modelElement instanceHash = value instanceHash ]
				ifFound: [ :target | 
					| edge |
					edge := OPUmlAssociationEdge new
						source: aShape;
						target: target;
						targetLabel:
							(OPUmlNameLabel new
								text: key;
								modelElement: key);
						modelElement: aShape modelElement -> key;
						headDecorator: RTSimpleArrow;
						yourself.
					edge renderIn: aView ]
				ifNone: [ OPUmlTypedElementLabel new
						owningElement: aShape;
						modelElement: key;
						text:
							(String
								streamContents: [ :stream | 
									stream << key.
									stream << ' = ' << value printString ]) ] ]