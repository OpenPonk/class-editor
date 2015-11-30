options
clashPrefix: aString
	"Prefix all generated classes that clash with existing classes with aString.
	Note that this shouldn't be used together with #prefix:.
	The difference is that #prefix: will always prefix all classes, and #clashPrefix: only those that need it.
	If the class already contains the name, then it is not added again."

	clashPrefix := aString