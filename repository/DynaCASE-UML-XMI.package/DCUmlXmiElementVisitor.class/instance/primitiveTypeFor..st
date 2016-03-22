as yet unclassified
primitiveTypeFor: aTypeElement
	| name |
	"<type xmi:type='uml:PrimitiveType' href='http://schema.omg.org/spec/UML/2.1/uml.xml#String'/>"
	aTypeElement @ #xmi:type = 'uml:PrimitiveType'
		ifTrue: [ name := (aTypeElement @ #href splitOn: '#') last.
			(#(#Integer #Boolean #String #UnlimitedNatural) includes: name)
				ifFalse: [ self error: 'Unrecognized primitive type' , name ].
			^ name ].
	name := aTypeElement @ #xmi:idref.
	(name beginsWith: 'EAJava_')
		ifTrue: [ ^ (name splitOn: '_') last ].
	"maybe create a new class instead?"
	self error: 'Unrecognized type ' , name