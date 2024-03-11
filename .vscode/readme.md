
Note: some of the basic settings may be better set at user level, even if recommended. See my user settings.json in [this repo](https://github.com/tloeber/utils_and_configs/tree/30875532bf7feed8c8f4c5c3612bd0cbc0a0b7ca/IDEs/VSCode).

To do:

- separate more cleanly between shared settings which should be tracked in this repo and individual settings which should not be tracked, some of that users don't have to deal with March conflicts and spurious notification of changed files in their working directory.
- Think more carefully about which files should go into settings versus workspace file. The advantage of the former is that it is shared between multiple workspaces for the same folder come on but some sightings such as appearance can't be set there.
