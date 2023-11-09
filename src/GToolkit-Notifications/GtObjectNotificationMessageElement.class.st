"
GtObjectNotificationMessageElement displays a {{gtClass:GtObjectNotificationMessage}}.  The display extends the standard message display to allow an attached object, e.g. an Exception, to be inspected.
"
Class {
	#name : #GtObjectNotificationMessageElement,
	#superclass : #GtNotificationMessageElement,
	#instVars : [
		'inspectButton'
	],
	#category : #'GToolkit-Notifications-Message'
}

{ #category : #private }
GtObjectNotificationMessageElement >> buttonTooltipLabel [
	self notificationDo: [ :aNotification |
		^ aNotification tooltip ifNil: [
			self defaultButtonLabel] ].
	^ self defaultButtonLabel
]

{ #category : #private }
GtObjectNotificationMessageElement >> defaultButtonLabel [
	^ 'Inspect attached object'
]

{ #category : #initialization }
GtObjectNotificationMessageElement >> initialize [
	super initialize.
	
	inspectButton := self newInspectButton.
	self borderElement containerDo: [ :container |
		container addChild: inspectButton ].
]

{ #category : #accessing }
GtObjectNotificationMessageElement >> inspectButton [
	^ inspectButton
]

{ #category : #private }
GtObjectNotificationMessageElement >> inspectObject [

	self notificationDo: [ :aNotification |
		GtWorldUtility 
			showObject: aNotification object 
			from: self ].
]

{ #category : #private }
GtObjectNotificationMessageElement >> newInspectButton [

	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude;
		action:  [ :button | self inspectObject ];
		icon: BrGlamorousVectorIcons inspect.
]

{ #category : #accessing }
GtObjectNotificationMessageElement >> onNotificationChanged [
	super onNotificationChanged.
	
	inspectButton label: self buttonTooltipLabel
]

{ #category : #accessing }
GtObjectNotificationMessageElement >> subscribeToNotification [
	self notificationDo: [ :aNotification | 
		aNotification
			when: GtNotificationDataChangedAnnouncement
			send: #onNotificationChanged
			to: self ]
]
