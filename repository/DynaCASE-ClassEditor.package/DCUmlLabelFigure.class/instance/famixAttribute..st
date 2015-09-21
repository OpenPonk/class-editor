*DynaCASE-ClassEditor-FAMIX
famixAttribute: anAttribute
	self model: anAttribute.
	self text: [ :m | self famixAttributeFor: m ].
	self emphasis: [ :m | self famixEmphasisFor: m ]