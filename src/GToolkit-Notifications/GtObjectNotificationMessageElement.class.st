"
GtObjectNotificationMessageElement displays a {{gtClass:GtObjectNotificationMessage}}.  The display extends the standard message display to allow an attached object, e.g. an Exception, to be inspected.
"
Class {
	#name : #GtObjectNotificationMessageElement,
	#superclass : #GtNotificationMessageElement,
	#category : #'GToolkit-Notifications-Message'
}

{ #category : #initialization }
GtObjectNotificationMessageElement >> initialize [

	super initialize.
	self borderElement containerDo: [ :container |
		container addChild: self newInspectButton ].
]

{ #category : #private }
GtObjectNotificationMessageElement >> inspectObject [

	self notificationDo: [ :aNotification |
		GtInspectorTool
			openWrappedOn: aNotification object
			title: 'Exception'
			from: self ].
]

{ #category : #private }
GtObjectNotificationMessageElement >> newInspectButton [

	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude;
		action:  [ :button | self inspectObject ];
		icon: BrGlamorousVectorIcons inspect;
		label: 'Inspect attached object' translated.

]
