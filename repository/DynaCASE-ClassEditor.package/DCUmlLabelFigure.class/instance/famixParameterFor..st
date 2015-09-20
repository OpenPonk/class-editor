*DynaCASE-ClassEditor-FAMIX
famixParameterFor: aParameter
	^ String
		streamContents: [ :s | 
			s
				nextPutAll: aParameter name;
				nextPutAll: ' : ';
				nextPutAll: aParameter declaredType name;
				nextPutAll: aParameter multiplicity asOptionalString ]