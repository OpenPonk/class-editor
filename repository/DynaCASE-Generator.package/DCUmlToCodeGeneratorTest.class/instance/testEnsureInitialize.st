as yet unclassified
testEnsureInitialize
	self deny: (cls includesSelector: #initialize).
	generator ensureHasInitialize: cls.
	self assert: (cls includesSelector: #initialize).
	generator ensureHasInitialize: cls.
	self assert: (cls includesSelector: #initialize)