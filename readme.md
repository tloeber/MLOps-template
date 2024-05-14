# Prerequisites

- Python version specified in Makefile needs to be available in the shell.
  - If using ASDF for managing Python versions, find available versions using `asdf python list python`, and then set python version for the project folder to one of the available versions (incl. patch version), e.g. `asdf  python 3.11.8`. (Note that this makes the minor version available in the shell *without* having to specify the patch version.)