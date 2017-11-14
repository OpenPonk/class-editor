tests - construction
testClassBeSource
	| sourceController |
	sourceController := OPUmlPackageController new.
	sourceController addAsSourceFor: controller.
	self assert: controller sourceController equals: sourceController