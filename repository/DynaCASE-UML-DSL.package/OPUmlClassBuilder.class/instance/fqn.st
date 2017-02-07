accessing
fqn
	^ ('::' asParser optional , symbol , ('::' asParser , symbol) star)
		==> [ :nodes | (nodes flattened asOrderedCollection removeAllSuchThat: #isNil) joinUsing: '' ]