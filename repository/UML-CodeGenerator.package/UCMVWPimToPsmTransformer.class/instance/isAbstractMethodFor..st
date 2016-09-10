transforming - meta
isAbstractMethodFor: aClass
	^ FAMIXMethod new
		name: 'isAbstract';
		protocol: 'testing';
		isStatic: true;
		sourceAnchor: (self isAbstractMethodSourceFor: aClass)