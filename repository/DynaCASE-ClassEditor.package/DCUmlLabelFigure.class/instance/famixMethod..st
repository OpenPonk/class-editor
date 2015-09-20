*DynaCASE-ClassEditor-FAMIX
famixMethod: aMethod
	self model: aMethod.
	self text: [ :m | self famixMethodFor: m ].
	self emphasis: [ :m | self famixEmphasisFor: m ]