package sx.widgets;

import hunit.TestCase;
import sx.transitions.Transition;
import sx.widgets.ViewStack;
import sx.widgets.Widget;



/**
 * sx.widgets.ViewStack
 *
 */
class ViewStackTest extends TestCase
{

    @test
    public function addChild_noChildrenYet_addedChildBecomesCurrent () : Void
    {
        var viewStack = new ViewStack();
        var child = new Widget();

        viewStack.addChild(child);

        assert.equal(child, viewStack.current);
    }


    @test
    public function addChild_alreadyHasChildren_addedChildBecomesInvisible () : Void
    {
        var viewStack = new ViewStack();
        viewStack.addChild(new Widget());
        var child = new Widget();

        viewStack.addChild(child);

        assert.isFalse(child.visible);
    }


    @test
    public function removeChild_RemovedCurrentView_currentBecomesNull () : Void
    {
        var viewStack = new ViewStack();
        viewStack.addChild(new Widget());
        viewStack.addChild(new Widget());
        var current = viewStack.current;

        viewStack.removeChild(current);

        assert.isNull(viewStack.current);
    }


    @test
    public function show_childWithSpecifiedNameExists_childWithSpecifiedNameBecomesCurrent () : Void
    {
        var viewStack = new ViewStack();
        viewStack.addChild(new Widget());
        var oldCurrent = viewStack.current;
        var newCurrent = new Widget();
        newCurrent.name = 'test';
        viewStack.addChild(newCurrent);

        viewStack.show(newCurrent.name);

        assert.equal(newCurrent, viewStack.current);
        assert.isTrue(newCurrent.visible);
        assert.isFalse(oldCurrent.visible);
    }


    @test
    public function show_onCompleteSpecifiedWithoutTransition_callsOnComplete () : Void
    {
        var called = false;
        var viewStack = new ViewStack();
        viewStack.addChild(new Widget());
        var child = viewStack.addChild(new Widget());
        child.name = 'test';

        viewStack.show(child.name, function() called = true);

        assert.isTrue(called);
    }


    @test
    public function show_withTransition_passesCorrectArgumentsToTransition () : Void
    {
        var transition = mock(Transition).stubAll().create();
        var viewStack = new ViewStack();
        viewStack.transition = transition;
        viewStack.addChild(new Widget());
        var child = viewStack.addChild(new Widget());
        child.name = 'test';
        var onComplete = function () {};

        expect(transition).change(viewStack.current, child, onComplete);

        viewStack.show(child.name, onComplete);
    }


    @test
    public function show_viewsSwitched_dispatchesOnChange () : Void
    {
        var dispatched = false;
        var viewStack = new ViewStack();
        viewStack.addChild(new Widget());
        var child = viewStack.addChild(new Widget());
        child.name = 'test';
        viewStack.onChange.add(function(vs) dispatched = true);

        viewStack.show(child.name);

        assert.isTrue(dispatched);
    }


    @test
    public function showIndex_childWithSpecifiedIndexExists_childWithSpecifiedIndexBecomesCurrent () : Void
    {
        var viewStack = new ViewStack();
        viewStack.addChild(new Widget());
        var oldCurrent = viewStack.current;
        var newCurrent = new Widget();
        viewStack.addChild(newCurrent);

        viewStack.showIndex(1);

        assert.equal(newCurrent, viewStack.current);
        assert.isTrue(newCurrent.visible);
        assert.isFalse(oldCurrent.visible);
    }


    @test
    public function showIndex_onCompleteSpecifiedWithoutTransition_callsOnComplete () : Void
    {
        var called = false;
        var viewStack = new ViewStack();
        viewStack.addChild(new Widget());
        var child = viewStack.addChild(new Widget());

        viewStack.showIndex(1, function() called = true);

        assert.isTrue(called);
    }


    @test
    public function showIndex_viewsSwitched_dispatchesOnChange () : Void
    {
        var dispatched = false;
        var viewStack = new ViewStack();
        viewStack.addChild(new Widget());
        var child = viewStack.addChild(new Widget());
        viewStack.onChange.add(function(vs) dispatched = true);

        viewStack.showIndex(1);

        assert.isTrue(dispatched);
    }


    @test
    public function showIndex_withTransition_passesCorrectArgumentsToTransition () : Void
    {
        var transition = mock(Transition).stubAll().create();
        var viewStack = new ViewStack();
        viewStack.transition = transition;
        viewStack.addChild(new Widget());
        var child = viewStack.addChild(new Widget());
        var onComplete = function () {};

        expect(transition).change(viewStack.current, child, onComplete);

        viewStack.showIndex(1, onComplete);
    }


    @test
    public function next_hasNextChild_switchesToNextChild () : Void
    {
        var viewStack = new ViewStack();
        viewStack.addChild(new Widget());
        var newCurrent = viewStack.addChild(new Widget());

        viewStack.next();

        assert.equal(newCurrent, viewStack.current);
    }


    @test
    public function next_doesNotHaveNextChildAndWrapIsFalse_doesNothing () : Void
    {
        var changedViews = false;
        var viewStack = new ViewStack();
        viewStack.wrap = false;
        viewStack.addChild(new Widget());
        viewStack.addChild(new Widget());
        viewStack.showIndex(-1);

        viewStack.next(function() changedViews = true);

        assert.isFalse(changedViews);
    }


    @test
    public function next_doesNotHaveNextChildAndWrapIsTrue_showsFirstChild () : Void
    {
        var changedViews = false;
        var viewStack = new ViewStack();
        viewStack.wrap = true;
        var firstChild = viewStack.addChild(new Widget());
        viewStack.addChild(new Widget());
        viewStack.showIndex(-1);

        viewStack.next(function() changedViews = true);

        assert.isTrue(changedViews);
        assert.equal(firstChild, viewStack.current);
    }


    @test
    public function previous_doesNotHavePreviousChildAndWrapIsFalse_doesNothing () : Void
    {
        var changedViews = false;
        var viewStack = new ViewStack();
        viewStack.wrap = false;
        viewStack.addChild(new Widget());
        viewStack.addChild(new Widget());

        viewStack.previous(function() changedViews = true);

        assert.isFalse(changedViews);
    }


    @test
    public function previous_doesNotHavePreviousChildAndWrapIsTrue_showsLastChild () : Void
    {
        var changedViews = false;
        var viewStack = new ViewStack();
        viewStack.wrap = true;
        viewStack.addChild(new Widget());
        var lastChild = viewStack.addChild(new Widget());

        viewStack.previous(function() changedViews = true);

        assert.isTrue(changedViews);
        assert.equal(lastChild, viewStack.current);
    }

}//class ViewStackTest