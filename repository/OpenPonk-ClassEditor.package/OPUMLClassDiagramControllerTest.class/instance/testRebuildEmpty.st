tests
testRebuildEmpty
	controller := self connectedControllerOn: OPUMLModel new.
	controller rebuild.
	self assert: controller view elements isEmpty