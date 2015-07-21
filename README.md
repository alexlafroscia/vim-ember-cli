# vim-ember-cli
Vim Plugin for the Ember CLI

It's pretty common to need to jump between the command line and your editor when doing development on Ember CLI applications.  This plugin provides some nice shortcuts for common Ember CLI tasks and adds tab-completion for file names in your project.

## Pre-Requisites & Installation

In addition to this plugin, this following others are also highly recommended:

- [tpope/vim-dispatch](https://github.com/tpope/vim-dispatch) -- Run commands asynchronously from Vim
- [SirVer/ultisnips](https://github.com/SirVer/ultisnips) -- "The ultimate snippet solution for Vim"

I recommend installing them through [vim-plug](https://github.com/junegunn/vim-plug), but you do what you want.

You don't have to install the above plugins, but the features that require them will be ignored.

## Demo

![vim-ember-cli usage demo](http://zippy.gfycat.com/DecentWellinformedEsok.gif)

## Usage

`vim-ember-cli` can be used to interface with the Ember CLI to execute most of the commands that you would normally need to go to the command for.  In addition, it also provides autocomplete for the `ember generate` and `ember destroy` commands, which isn't available at the command line

### Ember Generate

```
:EmberGen <type> <name>
```

Generate a new `<type>` with `<name>`.  `<name>` will be auto-completed based on the current structure of your project.  For example, if you want to create a new `controller` called `posts/post/edit` and you already have `posts/post`, then you can tab-complete `p<tab>/p<tab>/edit`.

### Ember Destroy

```
:EmberDestroy <type> <name>
```

Destroy a `<type>` with `<name>`.  You can use tab-completion to get find files that actually exist in your project, making it much easier to execute that it would be from the command line.

### Ember Test

```
:EmberTest
```

Run the entire test suite.  Tests are run asynchronously through [`vim-dispatch`](https://github.com/tpope/vim-dispatch).

```
:EmberTestModule
```

When run from a buffer containing an Ember test, run only that test.
