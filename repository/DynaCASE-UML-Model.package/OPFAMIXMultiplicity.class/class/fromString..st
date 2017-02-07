instance creation
fromString: aString
	"aString can be lower..upper range (6..9, 4..*), or UnlimitedNatural (5,8,*)"

	| pair lower upper |
	lower := upper := aString.
	upper = '*'
		ifTrue: [ lower := 0 ].
	pair := aString splitOn: '..'.
	pair size > 1
		ifTrue: [ lower := pair first.
			upper := pair second ].
	^ self fromArray: (Array with: lower with: upper)