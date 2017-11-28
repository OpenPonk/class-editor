initialization
generate: aProfile with: aDictionary
	| generator |
	generator := OPUMLProfileGenerator new.
	generator sourceModel: aProfile.
	generator classPrefix: (aDictionary at: #prefix).
	generator packageName: (aDictionary at: #package).
	(CBChangesBrowser changes: generator generateAll) open