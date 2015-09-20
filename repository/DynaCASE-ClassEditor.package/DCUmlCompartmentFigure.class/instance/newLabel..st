instance creation
newLabel: aOneArgBlock
	| figure |
	figure := self newLabel.
	self add: figure.
	aOneArgBlock value: figure