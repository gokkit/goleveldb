# Go LevelDB with modifications to read Minecraft Pocket Edition exported worlds

This is a fork of [syndtr/goleveldb](https://github.com/syndtr/goleveldb) for the sole purpose of using it to access Minecraft Pocket Edition exported .mcworld files.

I have successfully opened and read the db folder of an MCPE .mcworld file with these changes.
I have successfully written terrain blocks into the level and was able to play with the modified terrain.

My project using this fork: [midnightfreddie/McpeTool](https://github.com/midnightfreddie/McpeTool)


## Fork philosophy / strategy

In short, this fork is intended to work only with the db folder inside .mcworld files exported by MCPE. This involves
using zlib compression as previously-undefined compression types 2 and 4 for reading and writing instead of Snappy compression (type 1).
These changes will be made without regard to compatibility for other uses or for consistency with conflicting options settings or defaults.  

Since zlib and flate compression is non-standard in LevelDB, and since MCPE appears to be the only application using zlib and flate in LevelDB,
this project presumes there is no upstream interest in supporting zlib or flate compression. Reflexively, this fork has no reason
to support LevelDB outside of accessing MCPE world files. Therefore, upon future upstream syncs and updates:

- All self-repo import statements will be updated to this forked repo
- Writing will force zlib compression as compression type 2
- Compression type 2 will be read as zlib deflate
- Compression type 4 will be read as flate deflate
- Changes may be made that break or ignore options settings or default settings otherwise available in the upstream
