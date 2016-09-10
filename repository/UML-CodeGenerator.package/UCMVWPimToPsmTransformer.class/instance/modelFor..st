transforming
modelFor: aModel
	^ (self entityFor: aModel)
		name: aModel name , ' (PSM)';
		yourself