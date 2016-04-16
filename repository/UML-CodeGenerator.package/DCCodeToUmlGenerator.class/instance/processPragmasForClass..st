as yet unclassified
processPragmasForClass: aClass
	self processDirectAttributesIn: aClass.
	self processAssociationsIn: aClass.
	self processMethodsIn: aClass.
	self haltOnce