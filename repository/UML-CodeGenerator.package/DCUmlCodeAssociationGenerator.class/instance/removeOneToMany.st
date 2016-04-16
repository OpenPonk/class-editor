templates
removeOneToMany
	^ 'remove{nameSg}: {param}
	({name} includes: {param}) ifFalse: [ ^ self ].
	{name} remove: {param}.
	{param} {otherName}: nil'