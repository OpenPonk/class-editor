accessing
associationsGenerator
	^ associationsGenerator
		ifNil: [ (associationsGenerator := self associationsGeneratorFor: self context accessorsStyle)
				context: self context ]