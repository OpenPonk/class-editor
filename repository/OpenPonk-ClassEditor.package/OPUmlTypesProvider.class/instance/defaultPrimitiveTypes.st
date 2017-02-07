as yet unclassified
defaultPrimitiveTypes
	^ #(Boolean Integer Float String Symbol Object #nil)
		collect: [ :each | FAMIXClass new name: each ]