tests
testLeftEndWithRole
	self parse: 'Left role -' rule: #leftEnd.
	self parse: 'Left[*] role <' rule: #leftEnd