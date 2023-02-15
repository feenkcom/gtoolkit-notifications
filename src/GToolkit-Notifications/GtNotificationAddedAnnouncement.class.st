Class {
	#name : #GtNotificationAddedAnnouncement,
	#superclass : #GtNotificationsChangedAnnouncement,
	#instVars : [
		'addedNotification'
	],
	#category : #'GToolkit-Notifications-Announcements'
}

{ #category : #accessing }
GtNotificationAddedAnnouncement >> addedNotification [
	^ addedNotification
]

{ #category : #accessing }
GtNotificationAddedAnnouncement >> addedNotification: aNotification [
	addedNotification := aNotification
]
