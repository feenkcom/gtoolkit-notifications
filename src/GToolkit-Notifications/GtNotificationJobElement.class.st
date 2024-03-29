Class {
	#name : #GtNotificationJobElement,
	#superclass : #GtNotificationAbstractJobElement,
	#instVars : [
		'progressElement'
	],
	#category : #'GToolkit-Notifications-Job'
}

{ #category : #'private - asserting' }
GtNotificationJobElement >> assertJob: aJob [ 
	self 
		assert: [ aJob isNotNil ] 
		description: [ 'Job must be non-nil' ].
]

{ #category : #defaults }
GtNotificationJobElement >> defaultLayout [
	^ BlLinearLayout vertical alignCenterLeft
]

{ #category : #'private - accessing' }
GtNotificationJobElement >> dismissWishClass [
	^ GtNotificationJobDismissWish
]

{ #category : #initialization }
GtNotificationJobElement >> initialize [
	super initialize.
	self initializeProgressElement.
	
	self addChild: self progressElement as: #progress.
	
	self addAptitude: (BrLayoutResizerAptitude new
		hInherit;
		vAnyToFitContent;
		hInherit: self progressElement;
		vAnyToFitContent: self progressElement).
]

{ #category : #initialization }
GtNotificationJobElement >> initializeProgressElement [
	progressElement := BrProgress new
		fixedLabel: '';
		aptitude: BrGlamorousProgressWithLabelAndBarAptitude;
		layoutDo: [ :aLayout | 
			aLayout alignCenterLeft ]
]

{ #category : #'hooks - children' }
GtNotificationJobElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	self subscribeToJob.
	self updateElement.
]

{ #category : #'private - announcement handling' }
GtNotificationJobElement >> onJobChange: aJobChange [
	self jobDo: [ :aJob | 
		aJob = aJobChange job ifTrue: [
			self enqueueTask: (BlTaskAction new 
				action: [ self updateElement ] ) ] ].
]

{ #category : #'private - announcement handling' }
GtNotificationJobElement >> onJobEnd: aJobEnd [
	self jobDo: [ :aJob | 
		aJob = aJobEnd job ifTrue: [
			self unsubscribeFromJob.
			self enqueueTask: (BlTaskAction new 
				action: [ self dismiss ]) ] ].
]

{ #category : #'private - hooks' }
GtNotificationJobElement >> onNotificationChanged [
	super onNotificationChanged.
	self updateElement.
]

{ #category : #'hooks - children' }
GtNotificationJobElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	self unsubscribeFromJob.
]

{ #category : #'private - accessing' }
GtNotificationJobElement >> progressElement [
	<return: #BrProgress>
	^ progressElement
]

{ #category : #'private - subscriptions' }
GtNotificationJobElement >> subscribeToJob [
	self jobDo: [ :aJob | 
		aJob announcer
			when: JobEnd send: #onJobEnd: to: self;
			when: JobChange send: #onJobChange: to: self ].
]

{ #category : #'private - subscriptions' }
GtNotificationJobElement >> unsubscribeFromJob [
	self jobDo: [ :aJob | 
		aJob announcer unsubscribe: self ]
]

{ #category : #'private - updating' }
GtNotificationJobElement >> updateElement [
	self jobDo: [ :aJob | 
		| aProgress |
		aProgress := aJob progress.
		aProgress := aProgress max: 0.
		aProgress := aProgress min: 1.
		self progressElement
			fixedLabel: aJob title;
			fraction: aProgress ]
]
