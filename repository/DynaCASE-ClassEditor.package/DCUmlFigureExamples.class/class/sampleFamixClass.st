samples
sampleFamixClass
	| class n c0 c1 c2 cls multiplicityFor |
	multiplicityFor := [ :entity | 
	| mul |
	mul := entity multiplicity printRange.
	mul = '[1]'
		ifTrue: [ '' ]
		ifFalse: [ mul ] ].

	class := DCUmlExamples sampleCompleteClass allClasses first.

	c0 := DCUmlNameCompartmentFigure new.
	(n := c0 newNameFigure) text: class name.
	c0 add: n.

	c1 := DCUmlCompartmentFigure new.
	class attributes
		do:
			[ :each | 
			| figure emph |
			figure := DCUmlLabelFigure new.
			figure text: each name , ' : ' , each declaredType name , (multiplicityFor value: each).
			emph := Set new.
			each isStatic
				ifTrue: [ emph add: TextEmphasis underlined ].
			each isAbstract
				ifTrue: [ emph add: TextEmphasis italic ].
			figure emphasis: emph.
			c1 add: figure ].

	c2 := DCUmlCompartmentFigure new.
	class methods
		do:
			[ :each | 
			| figure emph text |
			text := each name , '('
				,
					((each parameters
						collect: [ :p | p name , ' : ' , p declaredType name , (multiplicityFor value: p) ])
						joinUsing: ' , ') , ')'.
			emph := Set new.
			each isStatic
				ifTrue: [ emph add: TextEmphasis underlined ].
			each isAbstract
				ifTrue: [ emph add: TextEmphasis italic ].
			each declaredType
				ifNotNil:
					[ text := text , ' : ' , each declaredType name , (multiplicityFor value: each) ].
			figure := DCUmlLabelFigure new.
			figure text: text.
			figure emphasis: emph.
			c2 add: figure ].

	cls := DCUmlClassFigure new.
	cls add: c0.
	cls add: c1.
	cls add: c2.

	^ cls