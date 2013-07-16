##Stencil

Rename your project with a single command.

###Install

gem install stencil

###Rename project

	mv my_project my_new_project
	cd my_new_project
	stencil

In this example, all instances of `my_project` become `my_new_project` and `MyProject` become `MyNewProject`.

Stencil replaces code and file names.

###Specify keywords

Sometimes you need to specify keywords to replace:

	stencil MyProject->MyNewProject my_project->my_new_project

###Replace file via inline comment

	puts "replace me"

	# -- replace
	# raise "replaced by me"

After running `stencil`, this ruby file would only contain `raise "replace by me"`.

This feature allows [gem_template](https://github.com/winton/gem_template) to self-replicate without copying the code used to self-replicate :).

###Contribute

[Create an issue](https://github.com/winton/stencil/issues/new) to discuss template changes.

Pull requests for template changes and new branches are even better.

###Stay up to date

[Star this project](https://github.com/winton/stencil#) on Github.

[Follow Winton Welsh](http://twitter.com/intent/user?screen_name=wintonius) on Twitter.
