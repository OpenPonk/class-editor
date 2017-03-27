as yet unclassified
asShape
	| el lbl comp compLbl |
	el := OPUmlCompartmentableShape new.
	el modelElement: self.
	lbl := OPUmlTypedElementLabel new.
	lbl
		text:
			(String
				streamContents: [ :stream | 
					name
						ifNotNil: [ stream
								<< name;
								<< ' ' ].
					stream << ': '.
					stream << classifier name ]).
	lbl
		localStyle:
			(OPUmlStyle new
				fontSize: 11;
				fontUnderline: true).
	lbl owningElement: el.
	comp := OPUmlCompartment new.
	comp owningElement: el.
	(slots" reject: [ :each | each isKindOf: self class ]")
		keysAndValuesDo: [ :key :value | 
			(compLbl := OPUmlTypedElementLabel new)
				owningElement: comp;
				modelElement: key;
				text:
					(String
						streamContents: [ :stream | 
							stream << key.
							stream << ' = ' << value printString ]) ].
	^ el