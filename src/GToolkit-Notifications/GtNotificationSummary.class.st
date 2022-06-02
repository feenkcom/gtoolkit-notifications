Class {
	#name : #GtNotificationSummary,
	#superclass : #BlElement,
	#instVars : [
		'notifications'
	],
	#category : #'GToolkit-Notifications-UI'
}

{ #category : #accessing }
GtNotificationSummary >> notifications [
	^ notifications
]

{ #category : #accessing }
GtNotificationSummary >> notifications: aCollection [
	notifications := aCollection.
	self onNotificationsChanged
]

{ #category : #accessing }
GtNotificationSummary >> onNotificationsChanged [
	"implemented by subclasses"
]
