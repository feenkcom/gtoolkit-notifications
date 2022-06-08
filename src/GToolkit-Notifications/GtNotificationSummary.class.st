Class {
	#name : #GtNotificationSummary,
	#superclass : #BlElement,
	#instVars : [
		'notifications',
		'updater'
	],
	#category : #'GToolkit-Notifications-UI'
}

{ #category : #accessing }
GtNotificationSummary >> initialize [
	super initialize.
	
	updater := BrElementUpdater new
		element: self
		selector: #onNotificationsChanged.
]

{ #category : #accessing }
GtNotificationSummary >> notifications [
	^ notifications
]

{ #category : #accessing }
GtNotificationSummary >> notifications: aCollection [
	notifications := aCollection.
	self requestUpdate
]

{ #category : #accessing }
GtNotificationSummary >> onNotificationsChanged [
	"implemented by subclasses"
]

{ #category : #accessing }
GtNotificationSummary >> requestUpdate [
	updater requestUpdate
]
