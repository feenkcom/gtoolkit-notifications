Class {
	#name : #BaselineOfGToolkitNotifications,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitNotifications
}

{ #category : #baseline }
BaselineOfGToolkitNotifications >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'Brick' with: [
				spec repository: 'github://feenkcom/Brick:v0.8.1633/src' ].
		spec
			baseline: 'GToolkitBasicUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.389/src' ].
		spec
			baseline: 'GToolkitAnnouncerUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.389/src' ].

		spec package: 'GToolkit-Notifications' with: [
			spec requires: #(#Brick #GToolkitBasicUtility #GToolkitAnnouncerUtility) ].
	]
]
