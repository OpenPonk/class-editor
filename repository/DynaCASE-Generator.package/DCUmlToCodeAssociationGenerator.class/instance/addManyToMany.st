templates
addManyToMany
	^ 'add{nameSg}: {param}
	({name} includes: {param}) ifTrue: [ ^ self ].
	{name} add: {param}.
	{param} add{otherNameSg}: self'