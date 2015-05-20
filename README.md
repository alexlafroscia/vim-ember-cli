# vim-ember-cli
Vim Plugin for the Ember CLI

It's pretty common to need to jump between the command line and your editor when doing development on Ember CLI applications, whether you're jumping to a generator or running your test suite.  This plugin provides some nice shortcuts for common Ember CLI tasks, and integrates with Projectionist to allow you to quickly jump between source and test files.

All commands attempt to use [Dispatch](https://github.com/tpope/vim-dispatch) to run asynchronously.

## Pre-Requisites & Installation

In addition to this plugin, this following others are also highly recommended:

- [tpope/vim-dispatch](https://github.com/tpope/vim-dispatch) -- Run commands asynchronously from Vim
- [SirVer/ultisnips](https://github.com/SirVer/ultisnips) -- "The ultimate snippet solution for Vim"

I recommend installing them through [vim-plug](https://github.com/junegunn/vim-plug), but you do what you want.

You don't have to install the above plugins, but the features that require them will be ignored.

## Examples

`:EmberGen controller my-controller`

Generate a new controller called "my-controller"

`:EmberDestroy controller my<TAB>`

Destroy the controller called "my-controller" (autocompletes file names)

`:EmberServe`

Start the ember server

`:EmberTest`

Run the test suite

See the [docs](https://github.com/alexlafroscia/vim-ember-cli/blob/master/doc/ember.txt) for more examples and an overview of all possible commands.
