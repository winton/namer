##Namer

Rename your project with a single command.

[![Build Status](https://secure.travis-ci.org/winton/namer.png)](http://travis-ci.org/winton/namer)

###Install

	gem install namer

###Rename project

	cd project
	namer project:new_project Project:NewProject

This replaces code and file names:

* `project` becomes `new_project`
* `Project` becomes `NewProject`

It will also replace the keywords on the git origin URL (if git repo).

###Replace file via inline comment

	puts "replace me"

	# -- replace
	# raise "replaced by me"

After running `namer`, this ruby file would only contain `raise "replace by me"`.

This feature allows [gem_template](https://github.com/winton/gem_template) to self-replicate without copying the code used to self-replicate :).

###Contribute

[Create an issue](https://github.com/winton/namer/issues/new) to discuss template changes.

Pull requests for template changes and new branches are even better.

###Stay up to date

[Star this project](https://github.com/winton/namer#) on Github.

[Follow Winton Welsh](http://twitter.com/intent/user?screen_name=wintonius) on Twitter.
