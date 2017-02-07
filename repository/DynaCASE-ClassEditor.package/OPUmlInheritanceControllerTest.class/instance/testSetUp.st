tests
testSetUp
	"Test that setUp of this class is as expected."

	self assert: diagramController controllers size equals: 2.
	self assert: diagramController controllers first equals: parentController.
	self assert: diagramController controllers second equals: childController.
	self assert: parentController model equals: parent.
	self assert: childController model equals: child