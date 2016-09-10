transforming - meta
typeMethodFor: anAttribute
	^ FAMIXMethod new
		name: anAttribute name , '_type';
		protocol: '+ parameter unit';
		isStatic: true;
		sourceAnchor: (self typeMethodSourceFor: anAttribute)