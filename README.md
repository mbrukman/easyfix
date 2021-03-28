# Easyfix

[![Build Status][github-ci-badge]][github-ci-url]

[github-ci-badge]: https://github.com/mbrukman/easyfix/actions/workflows/main.yml/badge.svg
[github-ci-url]: https://github.com/mbrukman/easyfix/actions/workflows/main.yml

Easyfix is a tool for making easy fixes to text files, enabling simple
large-scale cleanups of your code, documentation, or any other files.

Unlike other language-specific frameworks, Easyfix is language-agnostic and is
thus applicable to type of files, such as shell scripts, documentation, etc. Of
course, it can also be used with C++ and Java code, but since it is
language-agnostic, it does not parse the files and hence cannot do
language-semantics-aware editing.

At its core, Easyfix is a simple in-place rewriter using regular expressions,
which may be easier and faster to use for simple cleanups than getting out the
heavy machinery.

It also provides a very simple-to-use testing mechanism so you can verify that
your cleanup will affect exactly what you want to change and neither over-apply
nor under-apply the rewrite, before running the modification script on a large
tree of files.

## Usage

To use easyfix, simply create two files:

* **`<your_file>.sh`** to make the changes, and
* **`<your_file>_test.sh`** to verify the changes

See the [`examples`](examples) directory for samples of both types of files.

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for more details.

## License

Apache 2.0; see [`LICENSE`](LICENSE) for more details.

## Disclaimer

This is not an official Google project. It is not supported by Google and Google
specifically disclaims all warranties as to its quality, merchantability, or
fitness for a particular purpose.
