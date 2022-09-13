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
			baseline: 'Bloc' with: [
				spec repository: 'github://feenkcom/Bloc:v0.8.402/src' ].
		spec
			baseline: 'Brick' with: [
				spec repository: 'github://feenkcom/Brick:v0.8.690/src' ].
		spec
			baseline: 'GToolkitDebugger' with: [
				spec repository: 'github://feenkcom/gtoolkit-debugger:v0.8.1149/src' ].
		spec
			baseline: 'GToolkitCoder' with: [
				spec repository: 'github://feenkcom/gtoolkit-coder:v0.8.914/src' ].

		spec package: 'GToolkit-Notifications' with: [
			spec requires: #('Bloc' 'Brick' 'GToolkitCoder' 'GToolkitDebugger') ].
	]
]
