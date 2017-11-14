initialization
createRtEdge
	^ super createRtEdge
		in: [ :edge | edge shape decorate: [ :deco | deco dashdotLine ] ];
		yourself