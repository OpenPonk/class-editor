as yet unclassified
sortedHierarchyFor: classes
	^ classes asArray
		sorted: [ :a :b | (b superclassHierarchy includes: a) | (a superclassHierarchy includes: b) not ]