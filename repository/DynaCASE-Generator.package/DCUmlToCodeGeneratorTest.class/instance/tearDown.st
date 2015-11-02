running
tearDown
	cls
		ifNotNil: [ self suspendedDo: [ cls removeFromSystem ].
			cls := nil ]