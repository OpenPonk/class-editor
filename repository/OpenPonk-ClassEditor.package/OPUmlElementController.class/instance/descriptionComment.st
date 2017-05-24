forms
descriptionComment
	<magritteDescription>
	^ MAMemoDescription new
		accessor:
			(MAPluggableAccessor
				read: [ :me | me model ownedComments ifEmpty: [ '' ] ifNotEmpty: [ :oc | oc first body ] ]
				write: [ :me :newValue | 
					me model ownedComments ifEmpty: [ me model ownedComments add: OPUMLComment new ].
					me model ownedComments first body: newValue ]);
		label: 'Comment';
		priority: 100;
		yourself