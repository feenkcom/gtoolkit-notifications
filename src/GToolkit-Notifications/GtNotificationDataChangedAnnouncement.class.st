Class {
	#name : #GtNotificationDataChangedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'notification'
	],
	#category : #'GToolkit-Notifications-Announcements'
}

{ #category : #accessing }
GtNotificationDataChangedAnnouncement >> notification [

	^ notification
]

{ #category : #accessing }
GtNotificationDataChangedAnnouncement >> notification: aNotification [

	notification := aNotification
]
