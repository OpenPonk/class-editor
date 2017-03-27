as yet unclassified
printOn: aStream
	aStream
		<< 'InstSpec';
		<< '(';
		<< self name;
		<< ' : ';
		<< self classifier name;
		<< ')'