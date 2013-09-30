#Installation

- Install [php 5.3+](http://php.net/manual/en/install.php) [you should no way want to read laravel docs offline if you don't have it installed already :-)]
- Install [git](http://git-scm.com/book/en/Getting-Started-Installing-Git) if you already don't have it.
- Install [pandoc](http://johnmacfarlane.net/pandoc/installing.html) with recommended pdf library for your OS.
- Make sure all the above tools are available to be used in command line shell, otherwise update your $PATH environment variable to include these in your $PATH
- Clone this repo using following command from the terminal after moving into the directory where you want to keep the files

```sh
  git clone https://github.com/sphinxcorp/laravel-offline-docs-gen.git laravel-offline-docs-gen
```
#Generating offline documents

After you have completed the [installation](#installation) of required libraries & cloned the repo, you can build offline documentation for Laravel 4 by simply issueing following command from within the cloned directory.

```sh
  sh gen-doc.sh
```

With above command the documentation will be generated in **pdf** format with name **l4docs.pdf** in the same directory. For most cases this will suffice your need of using this tool, but if not, then move on...

##Output formats

The default output format is **pdf** & the default file name is **l4docs.pdf**, but as [pandoc](http://johnmacfarlane.net/pandoc/) is a versatile file format converter you can actually generate offline documents of any of format that [pandoc](http://johnmacfarlane.net/pandoc/) supports for output file. For example if you want to generate the offline document in **html** format, just pass a filename with **.html** extension as the first argument of the script as follows:

```sh
  sh gen-doc.sh l4docs.html
```

To know more about the supported formats see explanation of **-t** && **-o** options in [documentation for pandoc](http://johnmacfarlane.net/pandoc/README.html#options) or man page for pandoc

Additionally you can pass any [options](http://johnmacfarlane.net/pandoc/README.html#options) that pandoc supports to control or fine tune the generated document as per your need. For example, the following command will generate an **html5** document instead of **html4** (which is default for html output)

```sh
  sh gen-doc.sh l4docs.html -t html5
```

#Customization

To control the output of generated files, this tool uses [pandoc templates](http://johnmacfarlane.net/pandoc/README.html#templates) some default templates available from https://github.com/jgm/pandoc-templates as a git submodule. If you have the knowledge of customizing those templates, feel free to hack & twek the existing templates to meet your needs. Also for a comprehensive documentation of pandoc, please refer to the [github repo](https://github.com/jgm/pandoc) for pandoc.

#Contributing

If you find any bug, please file an issue in github issue tracker or fork & send pull request with fixes.