transforming - meta
unitMethodFor: anAttribute
	^ FAMIXMethod new
		name: anAttribute name , '_unit';
		protocol: '+ parameter unit';
		isStatic: true;
		sourceAnchor: (self unitMethodSourceFor: anAttribute)