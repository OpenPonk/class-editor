updating
refreshList
	| search dictionary |
	search := searchInput text asLowercase.
	dictionary := itemsBlock value associations.
	entriesList
		roots: dictionary;
		expandAll