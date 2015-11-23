accessing
leftEnd
	^ super leftEnd
		==>
			[ :nodes | 
			{nodes first.
			(DCFAMIXAssociationEnd new
				name: nodes third;
				multiplicity: nodes second;
				aggregation: nodes fourth first).
			nodes fourth second} ]