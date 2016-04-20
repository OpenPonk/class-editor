tests
testMetaMethods
	self assert: cls class instVarNames equals: #(#Default).
	self assert: (cls class selectors includes: #enum).
	self
		ast: (cls class >> #enum) ast
		equals:
			'enum
	"Generated method"
	^ Default ifNil: [ Default := self new ]'.
	self assert: (cls class >> #enum) protocol equals: 'accessing'