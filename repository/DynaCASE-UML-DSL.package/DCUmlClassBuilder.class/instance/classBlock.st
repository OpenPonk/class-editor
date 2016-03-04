accessing
classBlock
	^ (dslName, keyword , #blank asParser plus , block)
		==>
			[ :nodes | 
			(FAMIXClass named: nodes first second)
				stereotypes: nodes second;
				isAbstract: nodes first first;
				methods: (nodes fourth select: #isMethod);
				attributes: (nodes fourth select: #isAttribute) ]