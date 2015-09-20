rendering
renderIn: aView
	view := aView.
	view add: element.
	element addCallback: (TRTranslationCallback block: [ :shape :step | figures translateBy: step ]).
	self changed