Class {
	#name : #BaselineOfGToolkitNotifications,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitNotifications
}

{ #category : #baselines }
BaselineOfGToolkitNotifications >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'Brick'
					with: [ spec repository: 'github://feenkcom/Brick:main/src' ];
				baseline: 'GToolkitBasicUtility'
					with: [ spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ];
				baseline: 'GToolkitAnnouncerUtility'
					with: [ spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ].

			spec
				package: 'GToolkit-Notifications'
				with: [ spec requires: #(Brick GToolkitBasicUtility GToolkitAnnouncerUtility) ] ]
]
