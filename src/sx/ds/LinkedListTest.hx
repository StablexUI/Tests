package sx.ds;

import hunit.TestCase;


typedef TestList = sx.ds.LinkedList<String>;


/**
 * sx.ds.LinkedList
 *
 */
class LinkedListTest extends TestCase
{

    @test
    public function push_notItemsInList_pushedItemBecomesFirstItem () : Void
    {
        var list = new TestList();
        var item = 'hello';

        list.push(item);

        assert.equal(item, list.first);
    }


    @test
    public function push_hadItemsButNowEmpty_pushedItemBecomesFirstItem () : Void
    {
        var list = new TestList();
        var item = 'hello';

        list.push(item);

        assert.equal(item, list.first);
    }


    @test
    public function push_noItemsInList_pushedItemBecomesLastItem () : Void
    {
        var list = new TestList();
        var item = 'hello';

        list.push(item);

        assert.equal(item, list.last);
    }


    @test
    public function push_hasItems_pushedItemDoesNotBecomeFirstItem () : Void
    {
        var list = new TestList();
        var item = 'hello';
        list.push('world');

        list.push(item);

        assert.notEqual(item, list.first);
    }


    @test
    public function push_hasItems_pushedItemBecomesLastItem () : Void
    {
        var list = new TestList();
        var item = 'hello';
        list.push('world');

        list.push(item);

        assert.equal(item, list.last);
    }


    @test
    public function unshift_noItemsInList_unshiftedItemBecomesLastItem () : Void
    {
        var list = new TestList();
        var item = 'hello';

        list.unshift(item);

        assert.equal(item, list.last);
    }


    @test
    public function unshift_hasItemsInList_unshiftedDoesNotBecomeLastItem () : Void
    {
        var list = new TestList();
        var item = 'hello';
        list.push('world');

        list.unshift(item);

        assert.notEqual(item, list.last);
    }


    @test
    public function unshift_noItemsInList_unshiftedItemBecomesFirstItem () : Void
    {
        var list = new TestList();
        var item = 'hello';

        list.unshift(item);

        assert.equal(item, list.first);
    }


    @test
    public function unshift_hasItemsInList_unshiftedItemBecomesFirstItem () : Void
    {
        var list = new TestList();
        var item = 'hello';
        list.push('world');

        list.unshift(item);

        assert.equal(item, list.first);
    }

}//class LinkedListTest