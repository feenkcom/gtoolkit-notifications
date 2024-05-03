Class {
	#name : #GtNotificationEvent,
	#superclass : #GtAnnouncingNotification,
	#instVars : [
		'shouldShowNotifications'
	],
	#category : #'GToolkit-Notifications-Basic'
}

{ #category : #'api - accessing' }
GtNotificationEvent class >> empty [
	^ GtNotificationEmpty default
]

{ #category : #'api - notification' }
GtNotificationEvent >> addedTo: aGtNotifications [
	"Notifications may react"
]

{ #category : #'api - converting' }
GtNotificationEvent >> asElement [
	^ self elementClass new notification: self
]

{ #category : #'api - accessing' }
GtNotificationEvent >> elementClass [
	"Return a class that when instantiated displayes the notification to user (as a widget)"
	<return: #GtNotificationEventElement>
	^ GtNotificationMessageElement
]

{ #category : #'gt-extension' }
GtNotificationEvent >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		priority: 5;
		stencil: self
]

{ #category : #'api - accessing' }
GtNotificationEvent >> message [
	<return: #String>
	^ self printString
]

{ #category : #notifications }
GtNotificationEvent >> notifyNotificationDataChanged [
	self announce: (GtNotificationDataChangedAnnouncement new
		notification: self)
]

{ #category : #'api - subscriptions' }
GtNotificationEvent >> onRemovalRequestSend: aSelector to: aReceiver [
	self announcer weak
		when: GtNotificationRemovalRequest
		send: aSelector
		to: aReceiver
]

{ #category : #'api - hooks' }
GtNotificationEvent >> removedFrom: aNotifications [
	"Subclasses can react to notification removal"

	
]

{ #category : #'api - announcements' }
GtNotificationEvent >> requestRemoval [
	self announce: (GtNotificationRemovalRequest notification: self)
]

{ #category : #'api - accessing' }
GtNotificationEvent >> shouldShowNotifications [
	^ shouldShowNotifications ifNil: [ false ]
]

{ #category : #'api - configuration' }
GtNotificationEvent >> showNotifications [
	"Indicates that the list holding notifications should be 
	automatically shown when this notification is received."
	
	shouldShowNotifications := true
]

{ #category : #accessing }
GtNotificationEvent >> summaryClass [
	"Return a class that when instantiated displays the notification summary to the user"
	<return: #GtNotificationSummary>
	^ nil
]
