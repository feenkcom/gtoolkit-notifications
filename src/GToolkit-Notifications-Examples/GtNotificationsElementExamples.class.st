Class {
	#name : #GtNotificationsElementExamples,
	#superclass : #GtNotificationCommonExamples,
	#instVars : [
		'debugSessionExamples'
	],
	#category : #'GToolkit-Notifications-Examples'
}

{ #category : #'examples - notification' }
GtNotificationsElementExamples >> debugSessionExamples [
	<gtExample>
	<return: #GtNotificationDebugSessionExamples>
	^ debugSessionExamples
		ifNil: [ debugSessionExamples := GtNotificationDebugSessionExamples new ]
]

{ #category : #'examples - notification' }
GtNotificationsElementExamples >> debugSessionNotification [
	<gtExample>
	<return: #GtNotificationDebugSession>
	^ self debugSessionExamples debugSessionNotification
]

{ #category : #'examples - notification' }
GtNotificationsElementExamples >> notificationJob [
	<gtExample>
	<return: #GtNotificationJob>
	^ GtNotificationJobExamples new notificationJob
]

{ #category : #'examples - notification' }
GtNotificationsElementExamples >> notificationJobWithChild [
	<gtExample>
	<return: #GtNotificationJob>
	^ GtNotificationJobExamples new notificationJobWithChild
]

{ #category : #'examples - notification' }
GtNotificationsElementExamples >> notificationJobWithTwoChildren [
	<gtExample>
	<return: #GtNotificationJob>
	^ GtNotificationJobExamples new notificationJobWithTwoChildren
]

{ #category : #'examples - notification' }
GtNotificationsElementExamples >> notificationMessage [
	<gtExample>
	<return: #GtNotificationMessage>
	^ GtNotificationMessageExamples new notificationMessage
]
