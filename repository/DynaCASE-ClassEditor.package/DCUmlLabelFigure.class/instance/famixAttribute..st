*DynaCASE-ClassEditor-FAMIX
famixAttribute: anAttribute
	self model: anAttribute.
	self text: [ :m | m name , ' : ' , m declaredType name , m multiplicity asOptionalString ].
	self emphasis: [ :m | self famixEmphasisFor: m ]