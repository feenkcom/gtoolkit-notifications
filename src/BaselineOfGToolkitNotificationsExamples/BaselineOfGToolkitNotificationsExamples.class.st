Class {
	#name : #BaselineOfGToolkitNotificationsExamples,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitNotificationsExamples
}

{ #category : #baselines }
BaselineOfGToolkitNotificationsExamples >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'GToolkitNotifications'
					with: [ spec repository: 'github://feenkcom/gtoolkit-notifications:main/src' ].

			spec
				package: 'GToolkit-Notifications-Examples'
				with: [ spec requires: #(GToolkitNotifications) ] ]
]
