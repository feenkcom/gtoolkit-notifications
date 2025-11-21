Class {
	#name : #BaselineOfGToolkitNotificationsExamples,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitNotificationsExamples
}

{ #category : #baseline }
BaselineOfGToolkitNotificationsExamples >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'GToolkitNotifications' with: [
				spec repository: 'github://feenkcom/gtoolkit-notifications:v0.7.9/src' ].

		spec package: 'GToolkit-Notifications-Examples' with: [
			spec requires: #(#GToolkitNotifications) ].
	]
]
