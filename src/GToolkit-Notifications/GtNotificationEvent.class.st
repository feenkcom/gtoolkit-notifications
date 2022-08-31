Class {
	#name : #GtNotificationEvent,
	#superclass : #GtAnnouncingNotification,
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
	self announcer 
		when: GtNotificationRemovalRequest
		send: aSelector
		to: aReceiver
]

{ #category : #'api - announcements' }
GtNotificationEvent >> requestRemoval [
	self announce: (GtNotificationRemovalRequest notification: self)
]

{ #category : #accessing }
GtNotificationEvent >> summaryClass [
	"Return a class that when instantiated displays the notification summary to the user"
	<return: #GtNotificationSummary>
	^ nil
]
