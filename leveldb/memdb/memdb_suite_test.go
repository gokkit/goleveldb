package memdb

import (
	"testing"

	"github.com/midnightfreddie/goleveldb/leveldb/testutil"
)

func TestMemDB(t *testing.T) {
	testutil.RunSuite(t, "MemDB Suite")
}
