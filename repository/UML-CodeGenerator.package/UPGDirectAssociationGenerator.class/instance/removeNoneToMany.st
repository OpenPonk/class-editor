templates
removeNoneToMany
	^ 'remove{nameSg}: {param}
	({name} includes: {param}) ifFalse: [ ^ self ].
	{name} remove: {param}'