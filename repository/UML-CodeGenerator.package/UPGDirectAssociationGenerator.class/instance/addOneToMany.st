templates
addOneToMany
	^ 'add{nameSg}: {param}
	({name} includes: {param}) ifTrue: [ ^ self ].
	{name} add: {param}.
	{param} {otherName}: self'