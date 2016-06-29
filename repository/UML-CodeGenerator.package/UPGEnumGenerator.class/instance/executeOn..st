accessing
executeOn: anEnum
	| literals |
	self ensureClass: anEnum.
	literals := self literalsFor: anEnum.
	self ensureMetaMethodsIn: anEnum smalltalkClass class.
	literals
		associationsDo: [ :each | 
			self ensureInstanceMethodFor: each in: anEnum smalltalkClass.
			self tryClassMethodFor: each in: anEnum smalltalkClass ].