"
{{gtClass:GtNotificationsElement}} is an element that holds a list of  {{gtClass:name=GtNotifications}} and reacts to changes in that list.

Subclasses should override {{gtMethod:name=GtNotificationsElement>>#updateElement|label=#selector}} to specify how the element should update when notifications change. The actual update of the element is done using a {{gtClass:BrElementUpdater}}.
"
Class {
	#name : #GtNotificationsElement,
	#superclass : #GtNotificationElement,
	#instVars : [
		'notifications',
		'updater'
	],
	#category : #'GToolkit-Notifications-Badge'
}

{ #category : #callbacks }
GtNotificationsElement >> actOnNotificationAddedFor: anAnnouncement [
	self requestUpdate
]

{ #category : #callbacks }
GtNotificationsElement >> actOnNotificationRemovedFor: anAnnouncement [
	self requestUpdate
]

{ #category : #'private - asserting' }
GtNotificationsElement >> assertNotifications: aGtNotifications [ 
	self 
		assert: [ aGtNotifications isNotNil ] 
		description: [ 'Notifications must be non-nil' ].
]

{ #category : #'gt-extensions' }
GtNotificationsElement >> gtNotificationsFor: aView [
	<gtView>
	self notifications ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Notifications';
		object: [ self notifications ];
		view: #gtNotificationsFor:
]

{ #category : #initialization }
GtNotificationsElement >> initialize [
	super initialize.
	
	notifications := GtNotifications new.
	updater := BrElementUpdater new 
		postponedDuration: 100 milliSeconds;
		element: self selector: #updateElement.
		
	self subscribeToNotifications.
]

{ #category : #'api - adding / removing' }
GtNotificationsElement >> notification: aNotification [
	self notifications addNotification: aNotification.
]

{ #category : #'api - accessing' }
GtNotificationsElement >> notifications [
	<return: #GtNotifications>
	^ notifications
]

{ #category : #'api - accessing' }
GtNotificationsElement >> notifications: aGtNotifications [
	self assertNotifications: aGtNotifications.
	
	notifications = aGtNotifications ifTrue: [ ^ self ].
	self unsubscribeFromNotifications.
	notifications := aGtNotifications.
	self subscribeToNotifications.
	self onNotificationsChanged.
]

{ #category : #'api - accessing' }
GtNotificationsElement >> notificationsCount [
	<return: #Integer>
	^ self notifications size
]

{ #category : #'private - hooks' }
GtNotificationsElement >> onNotificationsChanged [
	self updateElement.
]

{ #category : #'api - adding / removing' }
GtNotificationsElement >> removeNotification: aGtNotificationEvent [ 
	self notifications removeNotification: aGtNotificationEvent
]

{ #category : #'private - updating' }
GtNotificationsElement >> requestUpdate [
	self updater requestUpdate.
]

{ #category : #'private - subscriptions' }
GtNotificationsElement >> subscribeToNotifications [
	self notifications 
		when: GtNotificationAddedAnnouncement
		send: #actOnNotificationAddedFor:
		to: self.
		
	self notifications 
		when: GtNotificationRemovedAnnouncement
		send: #actOnNotificationRemovedFor:
		to: self
]

{ #category : #'private - subscriptions' }
GtNotificationsElement >> unsubscribeFromNotifications [
	self notifications ifNotNil: [ :anAnnouncer | 
		anAnnouncer unsubscribe: self ].
]

{ #category : #'private - updating' }
GtNotificationsElement >> updateElement [
	"Subclasses may update their widgets"
]

{ #category : #'private - accessing' }
GtNotificationsElement >> updater [
	<return: #BrElementUpdater>
	^ updater
]
