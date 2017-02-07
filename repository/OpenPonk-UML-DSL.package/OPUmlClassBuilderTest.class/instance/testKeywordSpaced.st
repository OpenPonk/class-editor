tests
testKeywordSpaced
	self parse: '<< aaa , bbb >>' rule: #keyword.
	self assert: result first name equals: 'aaa'.
	self assert: result second name equals: 'bbb'