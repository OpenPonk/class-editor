tests-accessing
testAllTypes1
	| model profile |
	model := Array with: (FAMIXClass named: 'MyClass').
	profile := Array with: (FAMIXClass named: 'MyProfileClass').
	provider modelTypes: model.
	provider profileTypes: profile.
	self assert: provider allTypes keys equals: #(model profile primitives collections).
	self assert: (provider allTypes at: #model) equals: model.
	self assert: (provider allTypes at: #profile) equals: profile