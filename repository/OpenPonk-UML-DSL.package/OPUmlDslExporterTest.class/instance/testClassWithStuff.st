tests
testClassWithStuff
	self
		export:
			(self
				parseClass:
					'Mixin {
id
name : String
middleNames : String[*]
_workDays : String[5] = #(Monday Tuesday Wednesday Thursday Friday)
function()
inject:into:(aValue, aCollection)
add:afterIndex:(anObject : Object, anIndex: Integer) : Object
reject:(rejectBlock : BlockClosure[1]) : Object[*]
}')
		equals:
			'Mixin {
	id
	name : String
	middleNames : String[*]
	_workDays : String[5] = #(Monday Tuesday Wednesday Thursday Friday)
	function()
	inject:into:(aValue, aCollection)
	add:afterIndex:(anObject, anIndex : Integer) : Object
	reject:(rejectBlock : BlockClosure) : Object[*]
}'