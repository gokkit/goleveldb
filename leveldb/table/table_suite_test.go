package table

import (
	"testing"

	"github.com/midnightfreddie/goleveldb/leveldb/testutil"
)

func TestTable(t *testing.T) {
	testutil.RunSuite(t, "Table Suite")
}
