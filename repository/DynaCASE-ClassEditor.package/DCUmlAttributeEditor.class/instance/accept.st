private
accept
	self declaredTypeName
		ifNotNil: [ :name | self model declaredType: (FAMIXClass named: name) ].
	self model
		defaultValue: (self defaultValue ifNotNil: [ :val | DCFAMIXValueSpecification new valueExpression: val ]).
	onAccept value