tests
testCreateStaticAccessors
	model := FAMIXAttribute named: 'something' type: (FAMIXClass named: 'String').
	model isStatic: true.
	cls := Object subclass: #SomethingGenerated.
	generator createAttributeFor: model in: cls.
	self assert: cls selectors equals: #().
	self assertCollection: cls class selectors hasSameElements: #(#something: #something).
	self
		assert: (cls class >> #something:) ast
		equals: (RBParser parseMethod: 'something: aString something := aString').
	self
		assert: (cls class >> #something) ast
		equals:
			(RBParser parseMethod: 'something <DCType: #String multiplicity: #(1)> ^ something')