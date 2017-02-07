private
accept
	self declaredTypeName
		ifNotNil: [ :name | self model declaredType: (FAMIXClass named: name) ].
	self model
		unit: self unitInput text;
		defaultValue: (self defaultValue ifNotNil: [ :val | DCFAMIXValueSpecification new valueExpression: val ]).
	onAccept value