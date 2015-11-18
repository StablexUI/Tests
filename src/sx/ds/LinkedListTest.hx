package sx.ds;

import sx.TestCase;


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


    @test
    public function remove_lastItem_previouslyPushedBecomesLast () : Void
    {
        var list = new TestList();
        list.push('hello');
        list.push('world');

        var removed = list.remove('world');

        assert.isTrue(removed);
        assert.equal('hello', list.last);
    }


    @test
    public function remove_firstItem_secondItemBecomesFirst () : Void
    {
        var list = new TestList();
        list.push('hello');
        list.push('world');

        var removed = list.remove('hello');

        assert.isTrue(removed);
        assert.equal('world', list.first);
    }




}//class LinkedListTest