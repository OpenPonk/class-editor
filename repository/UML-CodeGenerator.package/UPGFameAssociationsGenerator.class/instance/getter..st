generator - templates
getter: anEnd
	^ self eagerGetter: anEnd
	"Lazy getter is not supported by FAME, eager will always be used"