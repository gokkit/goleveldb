# Go LevelDB with modifications to read Minecraft Portable Edition exported worlds

This is a fork of [syndtr/goleveldb](https://github.com/syndtr/goleveldb) for the sole purpose of using it to access Minecraft Portable Edition exported .mcworld files.

At this time, only the read function has been changed. I have successfully opened and read the db folder of an MCPE .mcworld file with these changes. MCPE-compatible writing is not yet implemented.

My project using this fork: [midnightfreddie/McpeTool](https://github.com/midnightfreddie/McpeTool)


## Fork philosophy / strategy

In short, this fork is intended to work only with the db folder inside .mcworld files exported by MCPE. This involves
using zlib compression as previously-undefined compression type 2 for reading and writing instead of Snappy compression (type 1).
These changes will be made without regard to compatibility for other uses or for consistency with conflicting options settings or defaults.  

Since zlib compression is non-standard in LevelDB, and since MCPE appears to be the only application using zlib in LevelDB,
this project presumes there is no upstream interest in supporting zlib compression. Reflexively, this fork has no reason
to support LevelDB outside of accessing MCPE world files. Therefore, upon future upstream syncs and updates:

- All self-repo import statements will be updated to this forked repo
- Reading and writing will force zlib compression as compression type 2
- Changes may be made that break or ignore options settings or default settings otherwise available in the upstream
