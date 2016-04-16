generator - method
methodParametersFor: aSelector in: aClass
	^ (aClass >> aSelector) argumentNames collect: [ :each | FAMIXParameter named: each ]