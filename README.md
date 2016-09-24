This is a fork of [syndtr/goleveldb](https://github.com/syndtr/goleveldb) for the sole purpose of using it to access Minecraft Portable Edition exported .mcworld files.
The change is to use zlib compression as previously-undefined compression type 2 instead of type 1 Snappy compression.

At this time, only the read function has been changed to use zlib compression. I have successfully opened and read MCPE with these changes.

My project using this fork: [midnightfreddie/McpeTool](https://github.com/midnightfreddie/goleveldb)

## Build instructions

Because of how Go handles $GOPATH and fully-qualified import library names, forking a project and making minor changes is a bit difficult.
Here is the best way to build, assuming $GOPATH is set and Go is installed:

    go get syndtr/goleveldb
	cd $GOPATH/src/github.com/syndtr/goleveldb
	# or the following for Windows
	cd %GOPATH%\src\github.com\syndtr\goleveldb
	git remote add mcpe https://github.com/midnightfreddie/goleveldb.git
	git pull mcpe master

This will apply this fork's changes to your local goleveldb.

Upstream readme:
-----

This is an implementation of the [LevelDB key/value database](http:code.google.com/p/leveldb) in the [Go programming language](http:golang.org).

[![Build Status](https://travis-ci.org/syndtr/goleveldb.png?branch=master)](https://travis-ci.org/syndtr/goleveldb)

Installation
-----------

	go get github.com/syndtr/goleveldb/leveldb

Requirements
-----------

* Need at least `go1.4` or newer.

Usage
-----------

Create or open a database:
```go
db, err := leveldb.OpenFile("path/to/db", nil)
...
defer db.Close()
...
```
Read or modify the database content:
```go
// Remember that the contents of the returned slice should not be modified.
data, err := db.Get([]byte("key"), nil)
...
err = db.Put([]byte("key"), []byte("value"), nil)
...
err = db.Delete([]byte("key"), nil)
...
```

Iterate over database content:
```go
iter := db.NewIterator(nil, nil)
for iter.Next() {
	// Remember that the contents of the returned slice should not be modified, and
	// only valid until the next call to Next.
	key := iter.Key()
	value := iter.Value()
	...
}
iter.Release()
err = iter.Error()
...
```
Seek-then-Iterate:
```go
iter := db.NewIterator(nil, nil)
for ok := iter.Seek(key); ok; ok = iter.Next() {
	// Use key/value.
	...
}
iter.Release()
err = iter.Error()
...
```
Iterate over subset of database content:
```go
iter := db.NewIterator(&util.Range{Start: []byte("foo"), Limit: []byte("xoo")}, nil)
for iter.Next() {
	// Use key/value.
	...
}
iter.Release()
err = iter.Error()
...
```
Iterate over subset of database content with a particular prefix:
```go
iter := db.NewIterator(util.BytesPrefix([]byte("foo-")), nil)
for iter.Next() {
	// Use key/value.
	...
}
iter.Release()
err = iter.Error()
...
```
Batch writes:
```go
batch := new(leveldb.Batch)
batch.Put([]byte("foo"), []byte("value"))
batch.Put([]byte("bar"), []byte("another value"))
batch.Delete([]byte("baz"))
err = db.Write(batch, nil)
...
```
Use bloom filter:
```go
o := &opt.Options{
	Filter: filter.NewBloomFilter(10),
}
db, err := leveldb.OpenFile("path/to/db", o)
...
defer db.Close()
...
```
Documentation
-----------

You can read package documentation [here](http:godoc.org/github.com/syndtr/goleveldb).
