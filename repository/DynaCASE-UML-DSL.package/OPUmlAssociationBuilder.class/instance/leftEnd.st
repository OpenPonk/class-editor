accessing
leftEnd
	^ super leftEnd
		==> [ :nodes | 
			{nodes first.
			(DCFAMIXProperty new
				name: nodes third;
				multiplicity: nodes second).
			nodes fourth first.
			nodes fourth second} ]