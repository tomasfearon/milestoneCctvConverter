milestoneCctvConverter.sh
===============================
This script will attempt to convert Mediadatabase exports containing .pic files from Milestone CCTV units into viewable video.

Dependencies
===============================
**bash**

**mencoder** - Available as part of mplayer

	http://www.mplayerhq.hu/design7/dload.html

Background
===============================
30 days worth of CCTV footage from multiple cameras was required from a crime scene. Because of the volume of footage, the Milestone CCTV unit could not export video as .avi files without crashing. The occupant therefore could only provide an export in the proprietary format used by the unit. 

The export provided by the occupant contained a 'Mediadatabase' directory, with several sub-folders. Each of these sub-folders contained another sub-folder named by the date the recording started. For example:

	  Mediadatabase/
		00075F8F646F_1/
		  2019-01-01-12-00/

The dated sub-folder contained several files of different formats, most notably .pic files - sometimes hundreds of them.

All .pic files were consistently 2.5MB large, and it was assumed that these would contain the video streams.

Mediainfo shows that they are H.264/MPEG-4 AVC video streams with 25 frames per second. 

To enable playback and to make review easier, this script traverses the Mediadatabase directory and concatenates the .pic files and packages them as an .avi

Usage
===============================
	./milestoneCctvConverter.sh [Path to Mediadatabase folder]

Known Issues/Bugs
===============================
All issues below are incredibly fixable, but as I am the only user (so far!) and they don't impact my use, they remain.
If you find this script useful, I would be more than happy to update it for you. 

**1) Filepaths must not contain any spaces**

**2) To exit before completiton once the script is running, you must close the terminal**

ctrl-c will just skip to the next mencoder run
	
**3) Current settings specific to the .pic files in my case**

Although this is the first such system I have encountered, it is likely that settings will differ between installations. The main one that will impact your output is the framerate.

If this is an issue, amend the -fps on line 73 to the correct value. Media info will show you the correct value for your particular GOPs.

If desired, I could update the script to detect fps settings automatically - email me if you require this.

If you have other examples of .pic files I could examine, I would be very grateful!

Contact
===============================
Questions or comments to tomasfearon@gmail.com


Thanks
===============================
Thanks to Spreadys.blog for some initial info that pointed me in the right direction. 

https://spreadys.wordpress.com/2012/12/07/hd-at-last/
