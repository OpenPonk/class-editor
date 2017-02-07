accessing
collectionTypes
	^ collectionTypes ifNil: [ collectionTypes := self defaultCollectionTypes ]