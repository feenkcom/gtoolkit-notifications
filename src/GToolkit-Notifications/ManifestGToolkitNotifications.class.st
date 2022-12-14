Class {
	#name : #ManifestGToolkitNotifications,
	#superclass : #PackageManifest,
	#category : #'GToolkit-Notifications-Manifest'
}

{ #category : #accessing }
ManifestGToolkitNotifications class >> mustNotDependOn [
	^ { 
		'GToolkit-Debugger'.
		'GToolkit-Pager'.
		'GToolkit-Coder-Examples'.
		'GToolkit-Pharo-Coder'.
		'GToolkit-Pharo-Coder-Method'.
		'GToolkit-Pharo-Coder-UI'
	}
]

{ #category : #accessing }
ManifestGToolkitNotifications >> mustOnlyDependOn [
	^ {
		'Announcements-Core'.
		'Bloc'.
		'Bloc-Layout'.
		'BlocHost-Morphic'.
		'Brick'.
		'Brick-Core'.
		'Brick-Glamorous'.
		'Brick-List-Ungrouped'.
		'Collections-Sequenceable'.
		'Colors'.
		'GToolkit-Utility-Announcer'.
		'GToolkit-Utility-Basic'.
		'Iceberg'.
		'Jobs'.
		'Kernel'.
	}
]
