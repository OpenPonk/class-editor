grammar
property
	^ prefix, visibility optional , propName , (($: asParser , propType) ==> [ :n | n second ]) optional , multiplicity, defaultValue optional