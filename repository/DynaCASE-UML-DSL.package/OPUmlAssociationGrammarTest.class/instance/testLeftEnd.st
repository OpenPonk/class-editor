tests
testLeftEnd
	self parse: 'Left -' rule: #leftEnd.
	self parse: 'Left[*] <' rule: #leftEnd