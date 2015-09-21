as yet unclassified
testEnsuring
	| name |
	name := class figures first.
	self assertCollection: (RTGroup with: name) equals: class figures