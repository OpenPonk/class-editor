transforming - meta
defaultMethodFor: anAttribute
	^ FAMIXMethod new
		name: anAttribute name , '_default';
		protocol: '- default value';
		isStatic: true;
		sourceAnchor: (self defaultMethodSourceFor: anAttribute)