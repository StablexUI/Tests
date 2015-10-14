package sx.widgets;

import hunit.TestCase;
import sx.backend.Backend;
import sx.exceptions.NotChildException;
import sx.exceptions.OutOfBoundsException;
import sx.properties.metric.Size;
import sx.properties.metric.Coordinate;
import sx.skins.Skin;
import sx.Sx;
import sx.widgets.Widget;



/**
 * Tests for `sx.widgets.Widget`
 *
 */
class WidgetTest extends TestCase
{
    @test
    public function addChild_childHasNoParent_childAddedToNewParentsDisplayList () : Void
    {
        var parent = new Widget();
        var child  = new Widget();

        parent.addChild(child);

        assert.isTrue(parent.contains(child));
    }


    @test
    public function addChild_childHasNoParent_childsParentPropertyPointsToNewParent () : Void
    {
        var parent = new Widget();
        var child  = new Widget();

        parent.addChild(child);

        assert.equal(parent, child.parent);
    }


    @test
    public function addChild_childHasAnotherParent_parentChangedToCorrectWidget () : Void
    {
        var oldParent = new Widget();
        var child = oldParent.addChild(new Widget());
        var newParent = new Widget();

        newParent.addChild(child);

        assert.equal(newParent, child.parent);
    }


    @test
    public function addChild_childIsInAnotherDisplayList_childRemovedFromAnotherDisplayList () : Void
    {
        var oldParent = new Widget();
        var child = oldParent.addChild(new Widget());
        var newParent = new Widget();

        newParent.addChild(child);

        assert.isFalse(oldParent.contains(child));
    }


    @test
    public function addChild_childIsInAnotherDisplayList_childAddedToNewDisplayList () : Void
    {
        var oldParent = new Widget();
        var child = oldParent.addChild(new Widget());
        var newParent = new Widget();

        newParent.addChild(child);

        assert.isTrue(newParent.contains(child));
    }


    @test
    public function addChild_firstChild_numChildrenIsOne () : Void
    {
        var widget = new Widget();

        widget.addChild(new Widget());

        assert.equal(1, widget.numChildren);
    }


    @test
    public function addChild_always_addsToTheEndOfChildrenList () : Void
    {
        var parent = new Widget();
        parent.addChild(new Widget());

        var lastChild = parent.addChild(new Widget());

        var expected = parent.numChildren - 1;
        var actual   = parent.getChildIndex(lastChild);
        assert.equal(expected, actual);
    }


    @test
    public function addChild_always_dispatchesOnChildAddedWithCorrectArguments () : Void
    {
        var correct : {
            parent : Bool,
            child  : Bool,
            index  : Bool
        } = null;
        var parent = new Widget();
        var child  = new Widget();
        parent.onChildAdded.add(function (p, c, i) {
            correct = {
                parent : (p == parent),
                child  : (c == child),
                index  : (i == 0)
            }
        });

        parent.addChild(child);

        assert.isTrue(correct.parent, 'Incorrect parent in onChildAdded signal');
        assert.isTrue(correct.child, 'Incorrect child in onChildAdded signal');
        assert.isTrue(correct.index, 'Incorrect index in onChildAdded signal');
    }


    @test
    public function addChild_always_dispatchesOnParentChangedWithCorrectArguments () : Void
    {
        var correct : {
            parent : Bool,
            child  : Bool,
            index  : Bool
        } = null;
        var parent = new Widget();
        var child  = new Widget();
        child.onParentChanged.add(function (p, c, i) {
            correct = {
                parent : (p == parent),
                child  : (c == child),
                index  : (i == 0)
            }
        });

        parent.addChild(child);

        assert.isTrue(correct.parent, 'Incorrect parent in onParentChanged signal');
        assert.isTrue(correct.child, 'Incorrect child in onParentChanged signal');
        assert.isTrue(correct.index, 'Incorrect index in onParentChanged signal');
    }


    @test
    public function removeChild_widgetToRemoveIsNotAChild_returnsNull () : Void
    {
        var parent = new Widget();

        var removed = parent.removeChild(new Widget());

        assert.isNull(removed);
    }


    @test
    public function removeChild_removed_childIsNotInDisplayListAnymore () : Void
    {
        var parent = new Widget();
        var child = parent.addChild(new Widget());

        parent.removeChild(child);

        assert.isFalse(parent.contains(child));
    }


    @test
    public function removeChild_removed_ChildsParentPropertyIsNull () : Void
    {
        var parent = new Widget();
        var child = parent.addChild(new Widget());

        parent.removeChild(child);

        assert.isNull(child.parent);
    }


    @test
    public function removeChild_theOnlyChild_numChildrenIsZero () : Void
    {
        var widget = new Widget();
        var child = widget.addChild(new Widget());

        widget.removeChild(child);

        assert.equal(0, widget.numChildren);
    }


    @test
    public function removeChild_always_dispatchesOnChildRemovedWithCorrectArguments () : Void
    {
        var correct : {
            parent : Bool,
            child  : Bool,
            index  : Bool
        } = null;
        var parent = new Widget();
        var child  = parent.addChild(new Widget());
        parent.onChildRemoved.add(function (p, c, i) {
            correct = {
                parent : (p == parent),
                child  : (c == child),
                index  : (i == 0)
            }
        });

        parent.removeChild(child);

        assert.isTrue(correct.parent, 'Incorrect parent in onChildRemoved signal');
        assert.isTrue(correct.child, 'Incorrect child in onChildRemoved signal');
        assert.isTrue(correct.index, 'Incorrect index in onChildRemoved signal');
    }


    @test
    public function removeChild_always_dispatchesOnParentChangedWithCorrectArguments () : Void
    {
        var correct : {
            parent : Bool,
            child  : Bool,
            index  : Bool
        } = null;
        var parent = new Widget();
        var child  = parent.addChild(new Widget());
        child.onParentChanged.add(function (p, c, i) {
            correct = {
                parent : (p == null),
                child  : (c == child),
                index  : (i == 0)
            }
        });

        parent.removeChild(child);

        assert.isTrue(correct.parent, 'Incorrect parent in onParentChanged signal');
        assert.isTrue(correct.child, 'Incorrect child in onParentChanged signal');
        assert.isTrue(correct.index, 'Incorrect index in onParentChanged signal');
    }


    @test
    public function contains_checkWidgetItself_returnsTrue () : Void
    {
        var widget = new Widget();

        var contains = widget.contains(widget);

        assert.isTrue(contains);
    }


    @test
    public function contains_checkedWidgetIsFirstLevelChild_returnsTrue () : Void
    {
        var parent = new Widget();
        var child = parent.addChild(new Widget());

        var contains = parent.contains(child);

        assert.isTrue(contains);
    }


    @test
    public function contains_checkedWidgetIsSecondLevelChild_returnsTrue () : Void
    {
        var parent = new Widget();
        var child = parent.addChild(new Widget()).addChild(new Widget());

        var contains = parent.contains(child);

        assert.isTrue(contains);
    }


    @test
    public function contains_checkedWidgetIsNotContainedByChecker_returnsFalse () : Void
    {
        var parent = new Widget();
        var widget = new Widget();

        var contains = parent.contains(widget);

        assert.isFalse(contains);
    }


    @test
    public function getChildIndex_widgetIsNotAChild_throwsNotChildException () : Void
    {
        var parent = new Widget();
        var widget = new Widget();

        expectException(match.type(NotChildException));

        parent.getChildIndex(widget);
    }


    @test
    public function getChildIndex_widgetIsChild_returnsCorrectIndex () : Void
    {
        var parent = new Widget();
        parent.addChild(new Widget());
        var secondChild = parent.addChild(new Widget());
        parent.addChild(new Widget());

        var index = parent.getChildIndex(secondChild);

        assert.equal(1, index);
    }


    @test
    public function addChildAt_indexIsInBounds_addsAtCorrectIndex () : Void
    {
        var parent = new Widget();
        parent.addChild(new Widget());
        parent.addChild(new Widget());
        parent.addChild(new Widget());
        var child = new Widget();

        parent.addChildAt(child, 2);

        var actual = parent.getChildIndex(child);
        assert.equal(2, actual);
    }


    @test
    public function addChildAt_indexExceedsNumChildren_addsToTheEndOfChildrenList () : Void
    {
        var parent = new Widget();
        parent.addChild(new Widget());
        parent.addChild(new Widget());
        parent.addChild(new Widget());
        var child = new Widget();

        parent.addChildAt(child, parent.numChildren + 1);

        var expected = parent.numChildren - 1;
        var actual   = parent.getChildIndex(child);
        assert.equal(expected, actual);
    }


    @test
    public function addChildAt_indexIsNegative_addsAtCorrectPosition () : Void
    {
        var parent = new Widget();
        parent.addChild(new Widget());
        parent.addChild(new Widget());
        parent.addChild(new Widget());
        var child = new Widget();

        parent.addChildAt(child, -2);

        var actual = parent.getChildIndex(child);
        assert.equal(1, actual);
    }


    @test
    public function addChildAt_childHasAnotherParent_parentChangedToCorrectWidget () : Void
    {
        var oldParent = new Widget();
        var child = oldParent.addChild(new Widget());
        var newParent = new Widget();

        newParent.addChildAt(child, 0);

        assert.equal(newParent, child.parent);
    }


    @test
    public function addChildAt_childIsInAnotherDisplayList_childRemovedFromAnotherDisplayList () : Void
    {
        var oldParent = new Widget();
        var child = oldParent.addChild(new Widget());
        var newParent = new Widget();

        newParent.addChildAt(child, 0);

        assert.isFalse(oldParent.contains(child));
    }


    @test
    public function addChildAt_childIsInAnotherDisplayList_childAddedToNewDisplayList () : Void
    {
        var oldParent = new Widget();
        var child = oldParent.addChild(new Widget());
        var newParent = new Widget();

        newParent.addChildAt(child, 0);

        assert.isTrue(newParent.contains(child));
    }


    @test
    public function addChildAt_always_dispatchesOnChildAddedWithCorrectArguments () : Void
    {
        var correct : {
            parent : Bool,
            child  : Bool,
            index  : Bool
        } = null;
        var parent = new Widget();
        var child  = new Widget();
        parent.onChildAdded.add(function (p, c, i) {
            correct = {
                parent : (p == parent),
                child  : (c == child),
                index  : (i == 0)
            }
        });

        parent.addChildAt(child, 10);

        assert.isTrue(correct.parent, 'Incorrect parent in onChildAdded signal');
        assert.isTrue(correct.child, 'Incorrect child in onChildAdded signal');
        assert.isTrue(correct.index, 'Incorrect index in onChildAdded signal');
    }


    @test
    public function addChildAt_always_dispatchesOnParentChangedWithCorrectArguments () : Void
    {
        var correct : {
            parent : Bool,
            child  : Bool,
            index  : Bool
        } = null;
        var parent = new Widget();
        var child  = new Widget();
        child.onParentChanged.add(function (p, c, i) {
            correct = {
                parent : (p == parent),
                child  : (c == child),
                index  : (i == 0)
            }
        });

        parent.addChildAt(child, 10);

        assert.isTrue(correct.parent, 'Incorrect parent in onParentChanged signal');
        assert.isTrue(correct.child, 'Incorrect child in onParentChanged signal');
        assert.isTrue(correct.index, 'Incorrect index in onParentChanged signal');
    }


    @test
    public function removeChildAt_indexOutOfBounds_returnsNull () : Void
    {
        var parent = new Widget();

        var removed = parent.removeChildAt(1);

        assert.isNull(removed);
    }


    @test
    public function removeChildAt_removed_childIsNotInDisplayListAnymore () : Void
    {
        var parent = new Widget();
        var child = parent.addChild(new Widget());

        parent.removeChildAt(0);

        assert.isFalse(parent.contains(child));
    }


    @test
    public function removeChildAt_removed_childsParentPropertyIsNull () : Void
    {
        var parent = new Widget();
        var child = parent.addChild(new Widget());

        parent.removeChildAt(0);

        assert.isNull(child.parent);
    }


    @test
    public function removeChildAt_theOnlyChild_numChildrenIsZero () : Void
    {
        var parent = new Widget();
        var child = parent.addChild(new Widget());

        parent.removeChildAt(0);

        assert.equal(0, parent.numChildren);
    }


    @test
    public function removeChildAt_hasMultipleChildren_removesCorrectChild () : Void
    {
        var parent = new Widget();
        parent.addChild(new Widget());
        var child = parent.addChild(new Widget());
        parent.addChild(new Widget());

        var removed = parent.removeChildAt(1);

        assert.equal(child, removed);
    }


    @test
    public function removeChildAt_negativeIndex_removesCorrectChild () : Void
    {
        var parent = new Widget();
        parent.addChild(new Widget());
        var child = parent.addChild(new Widget());
        parent.addChild(new Widget());

        var removed = parent.removeChildAt(-2);

        assert.equal(child, removed);
    }


    @test
    public function removeChildAt_always_dispatchesOnChildRemovedWithCorrectArguments () : Void
    {
        var correct : {
            parent : Bool,
            child  : Bool,
            index  : Bool
        } = null;
        var parent = new Widget();
        var child  = parent.addChild(new Widget());
        parent.onChildRemoved.add(function (p, c, i) {
            correct = {
                parent : (p == parent),
                child  : (c == child),
                index  : (i == 0)
            }
        });

        parent.removeChildAt(0);

        assert.isTrue(correct.parent, 'Incorrect parent in onChildRemoved signal');
        assert.isTrue(correct.child, 'Incorrect child in onChildRemoved signal');
        assert.isTrue(correct.index, 'Incorrect index in onChildRemoved signal');
    }


    @test
    public function removeChildAt_always_dispatchesOnParentChangedWithCorrectArguments () : Void
    {
        var correct : {
            parent : Bool,
            child  : Bool,
            index  : Bool
        } = null;
        var parent = new Widget();
        var child  = parent.addChild(new Widget());
        child.onParentChanged.add(function (p, c, i) {
            correct = {
                parent : (p == null),
                child  : (c == child),
                index  : (i == 0)
            }
        });

        parent.removeChildAt(0);

        assert.isTrue(correct.parent, 'Incorrect parent in onParentChanged signal');
        assert.isTrue(correct.child, 'Incorrect child in onParentChanged signal');
        assert.isTrue(correct.index, 'Incorrect index in onParentChanged signal');
    }


    @test
    public function removeChildren_indexesInBounds_removesExactAmountOfChildren () : Void
    {
        var parent = new Widget();
        for (i in 0...4) parent.addChild(new Widget());

        var amount = parent.removeChildren(1, 2);

        assert.equal(2, amount);
    }


    @test
    public function removeChildren_endIndexOutOfBounds_removesFromBeginIndexToTheEndOfDisplayList () : Void
    {
        var parent = new Widget();
        for (i in 0...4) parent.addChild(new Widget());

        var amount = parent.removeChildren(1, 10);

        assert.equal(3, amount);
    }


    @test
    public function removeChildren_beginIndexOutOfBounds_removesFromTheFirstChildUptoEndIndex () : Void
    {
        var parent = new Widget();
        for (i in 0...4) parent.addChild(new Widget());

        var amount = parent.removeChildren(-100, 2);

        assert.equal(3, amount);
    }


    @test
    public function removeChildren_negativeIndexes_removesCorrectAmountOfChildren () : Void
    {
        var parent = new Widget();
        for (i in 0...4) parent.addChild(new Widget());

        var amount = parent.removeChildren(-3, -2);

        assert.equal(2, amount);
    }


    @test
    public function removeChildren_removed_removedCorrectChildren () : Void
    {
        var parent = new Widget();
        var child0 = parent.addChild(new Widget());
        var child1 = parent.addChild(new Widget());
        var child2 = parent.addChild(new Widget());
        var child3 = parent.addChild(new Widget());

        parent.removeChildren(1, 2);

        var correct = (parent.contains(child0) && !parent.contains(child1) && !parent.contains(child2) && parent.contains(child3));
        assert.isTrue(correct);
    }


    @test
    public function removeChildren_removed_removedChildrenAreNotInDisplayListAnymore () : Void
    {
        var parent = new Widget();
        var child0 = parent.addChild(new Widget());
        var child1 = parent.addChild(new Widget());

        parent.removeChildren(0, 1);

        var notInDisplayList = (!parent.contains(child0) && !parent.contains(child1));
        assert.isTrue(notInDisplayList);
    }


    @test
    public function removeChildren_removed_removedChildrenHaveNullParent () : Void
    {
        var parent = new Widget();
        var child0 = parent.addChild(new Widget());
        var child1 = parent.addChild(new Widget());

        parent.removeChildren(0, 1);

        var nullParent = (child0.parent == null && child1.parent == null);
        assert.isTrue(nullParent);
    }


    @test
    public function removeChildren_childrenRemoved_decreasesNumChildrenCorrectly () : Void
    {
        var widget = new Widget();
        for (i in 0...5) widget.addChild(new Widget());
        var numChildren = widget.numChildren;

        widget.removeChildren(0, 2);

        var expected = numChildren - 3;
        assert.equal(expected, widget.numChildren);
    }


    @test
    public function removeChildren_defaultIndexes_removesAllChildren () : Void
    {
        var parent = new Widget();
        for (i in 0...4) parent.addChild(new Widget());

        parent.removeChildren();

        assert.equal(0, parent.numChildren);
    }


    @test
    public function setChildIndex_positiveIndexInBounds_childMovedToCorrectIndex () : Void
    {
        var parent = new Widget();
        var child  = parent.addChild(new Widget());
        parent.addChild(new Widget());
        parent.addChild(new Widget());

        var index = parent.setChildIndex(child, 2);

        var actual = parent.getChildIndex(child);
        assert.equal(2, actual);
        assert.equal(2, index);
    }


    @test
    public function setChildIndex_positiveOutOfBounds_childMovedToTheEndOfDisplayList () : Void
    {
        var parent = new Widget();
        var child = parent.addChild(new Widget());
        parent.addChild(new Widget());

        var index = parent.setChildIndex(child, 100);

        var actual = parent.getChildIndex(child);
        assert.equal(1, actual);
        assert.equal(1, index);
    }


    @test
    public function setChildIndex_negativeIndexInBounds_childMovedToCorrectIndex () : Void
    {
        var parent = new Widget();
        var child  = parent.addChild(new Widget());
        parent.addChild(new Widget());
        parent.addChild(new Widget());

        var index = parent.setChildIndex(child, -2);

        var actual = parent.getChildIndex(child);
        assert.equal(1, actual);
        assert.equal(1, index);
    }


    @test
    public function setChildIndex_negativeIndexOutOfBounds_childMovedToBeginningOfDisplayList () : Void
    {
        var parent = new Widget();
        parent.addChild(new Widget());
        parent.addChild(new Widget());
        var child = parent.addChild(new Widget());

        var index = parent.setChildIndex(child, -100);

        var actual = parent.getChildIndex(child);
        assert.equal(0, actual);
        assert.equal(0, index);
    }


    @test
    public function setChildIndex_widgetIsNotChild_throwsNotChildException () : Void
    {
        var parent = new Widget();
        var widget = new Widget();

        expectException(match.type(NotChildException));

        parent.setChildIndex(widget, 0);
    }


    @test
    public function getChildAt_positiveIndexInBounds_returnsCorrectChild () : Void
    {
        var parent = new Widget();
        parent.addChild(new Widget());
        var expected = parent.addChild(new Widget());
        parent.addChild(new Widget());

        var actual = parent.getChildAt(1);

        assert.equal(expected, actual);
    }


    @test
    public function getChildAt_negativeIndexInBounds_returnsCorrectChild () : Void
    {
        var parent = new Widget();
        parent.addChild(new Widget());
        var expected = parent.addChild(new Widget());
        parent.addChild(new Widget());

        var actual = parent.getChildAt(-2);

        assert.equal(expected, actual);
    }


    @test
    public function getChildAt_indexOutOfBounds_returnsNull () : Void
    {
        var parent = new Widget();
        for (i in 0...4) parent.addChild(new Widget());

        var child = parent.getChildAt(100);

        assert.isNull(child);
    }


    @test
    public function swapChildren_atLeastOneWidgetIsNotChild_throwsNotChildException () : Void
    {
        var parent = new Widget();
        var child  = parent.addChild(new Widget());
        var widget      = new Widget();

        expectException(match.type(NotChildException));

        parent.swapChildren(widget, child);
    }


    @test
    public function swapChildren_bothWidgetsAreChildren_swapsCorrectly () : Void
    {
        var parent = new Widget();
        var child0 = parent.addChild(new Widget());
        var child1 = parent.addChild(new Widget());

        parent.swapChildren(child0, child1);

        assert.equal(0, parent.getChildIndex(child1));
        assert.equal(1, parent.getChildIndex(child0));
    }


    @test
    public function swapChildrenAt_indexOutOfBounds_throwsOutOfBoundsException () : Void
    {
        var parent = new Widget();

        expectException(match.type(OutOfBoundsException));

        parent.swapChildrenAt(0, 1);
    }


    @test
    public function swapChildrenAt_positiveIndicesInBounds_swapsCorrectly () : Void
    {
        var parent = new Widget();
        var child0 = parent.addChild(new Widget());
        var child1 = parent.addChild(new Widget());

        parent.swapChildrenAt(0, 1);

        assert.equal(0, parent.getChildIndex(child1));
        assert.equal(1, parent.getChildIndex(child0));
    }


    @test
    public function swapChildrenAt_negativeIndicesInBounds_swapsCorrectly () : Void
    {
        var parent = new Widget();
        var child0 = parent.addChild(new Widget());
        var child1 = parent.addChild(new Widget());

        parent.swapChildrenAt(-2, -1);

        assert.equal(0, parent.getChildIndex(child1));
        assert.equal(1, parent.getChildIndex(child0));
    }


    @test
    public function width_percentageUnits_calculatedCorrectly () : Void
    {
        var parent = new Widget();
        var child = parent.addChild(new Widget());
        parent.width.dip = 50;

        child.width.pct = 20;

        assert.equal(10., child.width.dip);
    }


    @test
    public function onResize_parentWidthChangeWhileWidthPercent_dispatchedOnceWithWidth () : Void
    {
        var callAmount = 0;
        var withWidth  = false;
        var parent = new Widget();
        var child = parent.addChild(new Widget());
        child.width.pct = 20;
        child.onResize.add(function(w,s,u,p) {
            callAmount ++;
            withWidth = (s == child.width);
        });

        parent.width.dip = 50;

        assert.equal(1, callAmount);
        assert.isTrue(withWidth);
    }


    @test
    public function onResize_parentHeightChangeWhileHeightPercent_dispatchedOnceWithHeight () : Void
    {
        var callAmount = 0;
        var withHeight  = false;
        var parent = new Widget();
        var child = parent.addChild(new Widget());
        child.height.pct = 20;
        child.onResize.add(function(w,s,u,p) {
            callAmount ++;
            withHeight = (s == child.height);
        });

        parent.height.dip = 50;

        assert.equal(1, callAmount);
        assert.isTrue(withHeight);
    }


    @test
    public function height_percentageUnits_calculatedCorrectly () : Void
    {
        var parent = new Widget();
        var child = parent.addChild(new Widget());
        parent.height.dip = 50;

        child.height.pct = 20;

        assert.equal(10., child.height.dip);
    }


    @test
    public function size_changed_invokesOnResize () : Void
    {
        var resized = 0;
        var widget = new Widget();
        widget.onResize.add(function (w,s,u,v) resized++);

        widget.width.dip = 10;
        widget.height.dip = 10;

        assert.equal(2, resized);
    }


    @test
    public function size_changed_backendNotified () : Void
    {
        var widget = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;
        widget.initialize();

        expect(backend).widgetResized().exactly(2);

        widget.width.px = 100;
        widget.height.px = 10;
    }


    @test
    public function coordinates_widgetCreation_coordinatesInitializedCorrectly () : Void
    {
        var parent = new Widget();
        var widget = mock(Widget).create();
        parent.addChild(widget);

        assert.equal(widget.right, (widget.left:Coordinate).pair());
        assert.equal(widget.width, (widget.left:Coordinate).ownerSize());
        assert.equal(parent.width, (widget.left:Coordinate).pctSource());
        assert.isTrue(widget.left.selected);

        assert.equal(widget.left, (widget.right:Coordinate).pair());
        assert.equal(widget.width, (widget.right:Coordinate).ownerSize());
        assert.equal(parent.width, (widget.right:Coordinate).pctSource());
        assert.isFalse(widget.right.selected);

        assert.equal(widget.bottom, (widget.top:Coordinate).pair());
        assert.equal(widget.height, (widget.top:Coordinate).ownerSize());
        assert.equal(parent.height, (widget.top:Coordinate).pctSource());
        assert.isTrue(widget.top.selected);

        assert.equal(widget.top, (widget.bottom:Coordinate).pair());
        assert.equal(widget.height, (widget.bottom:Coordinate).ownerSize());
        assert.equal(parent.height, (widget.bottom:Coordinate).pctSource());
        assert.isFalse(widget.bottom.selected);
    }


    @test
    public function size_widgetCreation_sizeInitializedCorrectly () : Void
    {
        var parent  = new Widget();
        var widget  = new Widget();
        parent.addChild(widget);

        assert.equal(parent.width, (widget.left:Coordinate).pctSource());
        assert.equal(parent.height, (widget.height:Size).pctSource());
    }


    @test
    public function width_dependsOnParentResize_backendNotified () : Void
    {
        var parent = new Widget();
        var widget = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;
        parent.addChild(widget);
        widget.width.pct = 10;
        parent.initialize();

        expect(backend).widgetResized().once();

        parent.width.dip = 100;
    }


    @test
    public function height_dependsOnParentResize_backendNotified () : Void
    {
        var parent = new Widget();
        var widget = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;
        parent.addChild(widget);
        widget.height.pct = 10;
        parent.initialize();

        expect(backend).widgetResized().once();

        parent.height.dip = 100;
    }


    @test
    public function position_changed_invokesOnMove () : Void
    {
        var moved = 0;
        var widget = new Widget();
        widget.onMove.add(function (w,c,u,v) moved++);

        widget.left.dip   = 10;
        widget.right.dip  = 10;
        widget.top.dip    = 10;
        widget.bottom.dip = 10;

        assert.equal(4, moved);
    }


    @test
    public function position_changed_backendNotified () : Void
    {
        var widget = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;
        widget.initialize();

        expect(backend).widgetMoved().exactly(4);

        widget.left.dip   = 10;
        widget.right.dip  = 10;
        widget.top.dip    = 10;
        widget.bottom.dip = 10;
    }


    @test
    public function left_dependsOnParentResize_backendNotified () : Void
    {
        var parent = new Widget();
        var widget = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;
        parent.addChild(widget);
        widget.left.pct = 10;
        parent.initialize();

        expect(backend).widgetMoved().once();

        parent.width.dip = 100;
    }


    @test
    public function right_selectedWhileParentWidthChanged_backendNotified () : Void
    {
        var parent = new Widget();
        var widget = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;
        parent.addChild(widget);
        widget.right.px = 10;
        parent.initialize();

        expect(backend).widgetMoved().once();

        parent.width.dip = 100;
    }


    @test
    public function top_dependsOnParentResize_backendNotified () : Void
    {
        var parent = new Widget();
        var widget = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;
        parent.addChild(widget);
        widget.top.pct = 10;
        parent.initialize();

        expect(backend).widgetMoved().once();

        parent.height.dip = 100;
    }


    @test
    public function bottom_selectedWhileParentHeightChanged_backendNotified () : Void
    {
        var parent = new Widget();
        var widget = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;
        parent.addChild(widget);
        widget.bottom.px = 10;
        parent.initialize();

        expect(backend).widgetMoved().once();

        parent.height.dip = 100;
    }


    @test
    public function position_setByRightWidthChanged_invokesBackendWidgetMoved () : Void
    {
        var widget = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;
        widget.right.px = 10;
        widget.initialize();

        expect(backend).widgetMoved().once();

        widget.width.px = 100;
    }


    @test
    public function position_setByBottomHeightChanged_invokesBackendWidgetMoved () : Void
    {
        var widget = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;
        widget.right.px = 10;
        widget.initialize();

        expect(backend).widgetMoved().once();

        widget.width.px = 100;
    }


    @test
    public function origin_originChanged_backendNotified () : Void
    {
        var widget = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;
        widget.initialize();

        expect(backend).widgetOriginChanged().once();

        widget.origin.set(0.5, 0.5);
    }


    @test
    public function offset_offsetChanged_backendNotified () : Void
    {
        var widget = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;
        widget.initialize();

        expect(backend).widgetOffsetChanged().once();

        widget.offset.left.dip = 2;
    }


    @test
    public function scaleX_changed_backendNotified () : Void
    {
        var widget = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;
        widget.initialize();

        expect(backend).widgetScaledX().once();

        widget.scaleX = 0.5;
    }


    @test
    public function scaleY_changed_backendNotified () : Void
    {
        var widget = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;
        widget.initialize();

        expect(backend).widgetScaledY().once();

        widget.scaleY = 0.5;
    }


    @test
    public function rotation_changed_backendNotified () : Void
    {
        var widget = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;
        widget.initialize();

        expect(backend).widgetRotated().once();

        widget.rotation = 0.5;
    }


    @test
    public function alpha_changed_backendNotified () : Void
    {
        var widget = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;
        widget.initialize();

        expect(backend).widgetAlphaChanged().once();

        widget.alpha = 0.5;
    }


    @test
    public function visible_changed_backendNotified () : Void
    {
        var widget = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;
        widget.initialize();

        expect(backend).widgetVisibilityChanged().once();

        widget.visible = false;
    }


    @test
    public function dispose_dontDisposeChildren_childrenRemovedButNotDisposed () : Void
    {
        var parent = new Widget();
        var child = mock(Widget).create();
        parent.addChild(child);

        expect(child).dispose().never();

        parent.dispose(false);
    }


    @test
    public function dispose_disposeChildrenAsWell_childrenDisposed () : Void
    {
        var parent = new Widget();
        var child = mock(Widget).create();
        parent.addChild(child);

        expect(child).dispose().once();

        parent.dispose();
    }


    @test
    public function dispose_hasActiveTweens_stopsAllTweens () : Void
    {
        var widget = new Widget();
        widget.tween.tween(1, widget.rotation = 90);
        assert.isTrue(widget.tween.active);

        widget.dispose();

        assert.isFalse(widget.tween.active);
    }


    @test
    public function skin_setByName_usesRegisteredSkin () : Void
    {
        var name = 'test';
        Sx.registerSkin(name, function () return new Skin());
        var widget = new Widget();

        widget.skin = name;

        assert.notNull(widget.skin);
    }


    @test
    public function skin_setSkin_invokesSkinUsedBy () : Void
    {
        var widget = new Widget();
        var skin = mock(Skin).create();

        expect(skin).usedBy(widget).once();

        widget.skin = skin;
    }


    @test
    public function skin_removeSkin_invokesSkinRemoved () : Void
    {
        var widget = new Widget();
        var skin = mock(Skin).create();
        widget.skin = skin;

        expect(skin).removed().once();

        widget.skin = null;
    }


    @test
    public function skin_setSkin_invokesBackendWidgetSkinChanged () : Void
    {
        var widget = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;
        widget.initialize();

        expect(backend).widgetSkinChanged().once();

        widget.skin = new Skin();
    }


    @test
    public function skin_setNullWhileHasSkin_invokesBackendWidgetSkinChanged () : Void
    {
        var widget = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;
        widget.skin = new Skin();
        widget.initialize();

        expect(backend).widgetSkinChanged().once();

        widget.skin = null;
    }


    @test
    public function disposed_afterDisposeWasCalled_disposedEqualsTrue () : Void
    {
        var widget = new Widget();

        widget.dispose();

        assert.isTrue(widget.disposed);
    }


    @test
    public function enabled_changedToFalse_dispatchesOnDisableSignal () : Void
    {
        var dispatched = false;
        var widget = new Widget();
        widget.enabled = true;
        widget.onDisable.add(function(w) dispatched = true);

        widget.enabled = false;

        assert.isTrue(dispatched);
    }


    @test
    public function enabled_changedToTrue_dispatchesOnEnableSignal () : Void
    {
        var dispatched = false;
        var widget = new Widget();
        widget.enabled = false;
        widget.onEnable.add(function(w) dispatched = true);

        widget.enabled = true;

        assert.isTrue(dispatched);
    }


    @test
    public function isEnabled_allParentsAreEnabled_returnsTrue () : Void
    {
        var level3 = new Widget().addChild(new Widget()).addChild(new Widget());

        var enabled = level3.isEnabled();

        assert.isTrue(enabled);
    }


    @test
    public function isEnabled_oneOfParentsIsDisabled_returnsFalse () : Void
    {
        var root = new Widget();
        var level3 = root.addChild(new Widget()).addChild(new Widget());
        root.enabled = false;

        var enabled = level3.isEnabled();

        assert.isFalse(enabled);
    }


    @test
    public function initialize_calledFirstTime_dispatchesOnInitializeSignal () : Void
    {
        var dispatched = false;
        var widget = new Widget();
        widget.onInitialize.add(function (w) dispatched = true);

        widget.initialize();

        assert.isTrue(dispatched);
    }


    @test
    public function initialize_calledSecondTime_doesNotDispatchOnInitializeSignal () : Void
    {
        var dispatched = false;
        var widget = new Widget();
        widget.initialize();
        widget.onInitialize.add(function (w) dispatched = true);

        widget.initialize();

        assert.isFalse(dispatched);
    }


    @test
    public function initialized_widgetWasInitialized_initializedIsTrue () : Void
    {
        var widget = new Widget();
        assert.isFalse(widget.initialized);

        widget.initialize();

        assert.isTrue(widget.initialized);
    }


    @test
    public function initialized_notInitializedChildAddedToInitializedParent_childBecomesInitialized () : Void
    {
        var parent = new Widget();
        parent.initialize();
        var child = new Widget();

        parent.addChild(child);

        assert.isTrue(child.initialized);
    }

}//class WidgetTest
