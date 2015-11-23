accessing
classBlock
	^ (dslName , #blank asParser plus , block)
		==>
			[ :nodes | 
			(FAMIXClass named: nodes first second)
				isAbstract: nodes first first;
				methods: (nodes third select: #isMethod);
				attributes: (nodes third select: #isAttribute) ]