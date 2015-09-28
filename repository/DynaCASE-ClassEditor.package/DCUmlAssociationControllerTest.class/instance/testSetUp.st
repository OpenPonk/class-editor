tests
testSetUp
	"Test that setUp of this class is as expected."

	self assert: diagramController controllers size equals: 2.
	self assert: diagramController controllers first equals: targetController.
	self assert: diagramController controllers second equals: sourceController.
	self assert: targetController model equals: target.
	self assert: sourceController model equals: source