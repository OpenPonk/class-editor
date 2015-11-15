generator - method
createMethodFor: aSelector in: aClass
	(aClass >> aSelector) pragmas
		detect: [ :each | each keyword = #DCMethod: ]
		ifFound: [ :pragma | ^ factory method: pragma arguments first ].
	^ FAMIXMethod new
		name: aSelector;
		parameters: (self methodParametersFor: aSelector in: aClass);
		declaredType: (self methodTypeFor: aSelector in: aClass)