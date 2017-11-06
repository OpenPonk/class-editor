testing
isAppliedProfileInUse
	model profileApplications ifEmpty: [ ^ false ].
	^ model packagedElements anySatisfy: [ :each | each appliedStereotypes isNotEmpty ]