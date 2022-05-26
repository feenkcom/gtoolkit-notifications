Class {
	#name : #BaselineOfGToolkitNotifications,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitNotifications
}

{ #category : #baselines }
BaselineOfGToolkitNotifications >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			baseline: 'Bloc' with: 
				[ spec repository: 'github://feenkcom/Bloc:main/src' ];
			baseline: 'Brick' 	with: 
				[ spec repository: 'github://feenkcom/Brick:main/src' ];
			baseline: 'GToolkitDebugger' with: 
				[ spec repository: 'github://feenkcom/gtoolkit-debugger:main/src' ];
			baseline: 'GToolkitCoder' with: 
				[ spec repository: 'github://feenkcom/gtoolkit-coder:main/src' ].

		spec 
			package: 'GToolkit-Notifications' with:
				[ spec requires: #(Bloc Brick GToolkitCoder GToolkitDebugger) ]
	]
]
