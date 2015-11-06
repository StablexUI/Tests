package sx.ds;

import hunit.TestCase;
import sx.ds.ObjectPool;



/**
 * sx.ds.ObjectPool
 *
 */
class ObjectPoolTest extends TestCase
{

    @test
    public function pop_poolIsEmpty_returnsNull () : Void
    {
        var pool = new ObjectPool<String>();

        var item = pool.pop();

        assert.isNull(item);
        assert.equal(0, pool.length);
    }


    @test
    public function pop_poolHasItems_returnsPreviouslyPushedItem () : Void
    {
        var pool = new ObjectPool<String>();
        var item = 'hello';
        pool.push(item);

        var actual = pool.pop();

        assert.equal(item, actual);
        assert.equal(0, pool.length);
    }


    @test
    public function push_always_lengthIncreasedByOne () : Void
    {
        var pool = new ObjectPool<String>();

        pool.push('hello');

        assert.equal(1, pool.length);
    }

    @test
    public function clear_always_removesAllItems () : Void
    {
        var pool = new ObjectPool<String>();
        pool.push('hello');
        pool.push('world');

        pool.clear();

        assert.equal(0, pool.length);
        assert.isNull(pool.pop());
    }

}//class ObjectPoolTest