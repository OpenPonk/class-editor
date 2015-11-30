templates
removeManyToMany
	^ 'remove{nameSg}: {param}
	({name} includes: {param}) ifFalse: [ ^ self ].
	{name} remove: {param}.
	{param} remove{otherNameSg}: self'