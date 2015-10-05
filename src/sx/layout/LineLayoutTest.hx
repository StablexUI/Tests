package sx.layout;

import sx.properties.Align;
import sx.properties.Orientation;
import hunit.TestCase;
import sx.layout.LineLayout;
import sx.widgets.Widget;


/**
 * sx.layout.LineLayout
 *
 */
class LineLayoutTest extends TestCase
{

    @test
    public function arrangeChildren_horizontalOrientationLeftAlign_childrenArrangedCorrectly () : Void
    {
        var widget = new Widget();
        var child1 = widget.addChild(new Widget());
        var child2 = widget.addChild(new Widget());

        child1.width.px = 100;
        child2.width.px = 70;

        var layout = new LineLayout();
        layout.autoSize.set(true, true);
        layout.align.horizontal = Left;
        layout.orientation = Horizontal;
        layout.padding.left.px = 5;
        layout.padding.right.px = 10;
        layout.gap.px = 5;

        widget.layout = layout;

        assert.equal(5., child1.left.px);
        assert.equal(5. + 100 + 5, child2.left.px);
    }


    @test
    public function arrangeChildren_horizontalOrientationRightAlign_childrenArrangedCorrectly () : Void
    {
        var widget = new Widget();
        var child1 = widget.addChild(new Widget());
        var child2 = widget.addChild(new Widget());

        child1.width.px = 100;
        child2.width.px = 70;

        var layout = new LineLayout();
        layout.autoSize.set(true, true);
        layout.align.horizontal = Right;
        layout.orientation = Horizontal;
        layout.padding.left.px = 5;
        layout.padding.right.px = 10;
        layout.gap.px = 5;

        widget.layout = layout;

        assert.equal(10. + 5 + 70, child1.right.px);
        assert.equal(10., child2.right.px);
    }


    @test
    public function arrangeChildren_horizontalOrientationCenterAlign_childrenArrangedCorrectly () : Void
    {
        var widget = new Widget();
        var child1 = widget.addChild(new Widget());
        var child2 = widget.addChild(new Widget());

        child1.width.px = 100;
        child2.width.px = 70;
        widget.width.px = 200;

        var layout = new LineLayout();
        layout.autoSize.set(false, false);
        layout.align.horizontal = Center;
        layout.orientation = Horizontal;
        layout.gap.px = 5;

        widget.layout = layout;

        var firstPos = 0.5 * (200 - 100 - 70 - 5);
        assert.equal(firstPos, child1.left.px);
        assert.equal(firstPos + 5 + 100, child2.left.px);
    }


    @test
    public function arrangeChildren_verticalOrientationLeftAlign_childrenArrangedCorrectly () : Void
    {
        var widget = new Widget();
        var child1 = widget.addChild(new Widget());
        var child2 = widget.addChild(new Widget());

        child1.width.px = 100;
        child2.width.px = 70;

        var layout = new LineLayout();
        layout.autoSize.set(true, true);
        layout.align.horizontal = Left;
        layout.orientation = Vertical;
        layout.padding.left.px = 5;

        widget.layout = layout;

        assert.equal(5., child1.left.px);
        assert.equal(5., child2.left.px);
    }


    @test
    public function arrangeChildren_verticalOrientationRightAlign_childrenArrangedCorrectly () : Void
    {
        var widget = new Widget();
        var child1 = widget.addChild(new Widget());
        var child2 = widget.addChild(new Widget());

        child1.width.px = 100;
        child2.width.px = 70;

        var layout = new LineLayout();
        layout.autoSize.set(true, true);
        layout.align.horizontal = Right;
        layout.orientation = Vertical;
        layout.padding.right.px = 5;

        widget.layout = layout;

        assert.equal(5., child1.right.px);
        assert.equal(5., child2.right.px);
    }


    @test
    public function arrangeChildren_verticalOrientationCenterAlign_childrenArrangedCorrectly () : Void
    {
        var widget = new Widget();
        var child1 = widget.addChild(new Widget());
        var child2 = widget.addChild(new Widget());

        child1.width.px = 100;
        child2.width.px = 70;

        var layout = new LineLayout();
        layout.autoSize.set(true, true);
        layout.align.horizontal = Center;
        layout.orientation = Vertical;
        layout.padding.left.px = 5;
        layout.padding.right.px = 10;

        widget.layout = layout;

        var middle = (5 + 10 + 100) * 0.5;
        assert.equal(middle - 50, child1.left.px);
        assert.equal(middle - 35, child2.left.px);
    }


    //--------------


    @test
    public function arrangeChildren_verticalOrientationTopAlign_childrenArrangedCorrectly () : Void
    {
        var widget = new Widget();
        var child1 = widget.addChild(new Widget());
        var child2 = widget.addChild(new Widget());

        child1.height.px = 100;
        child2.height.px = 70;

        var layout = new LineLayout();
        layout.autoSize.set(true, true);
        layout.align.vertical = Top;
        layout.orientation = Vertical;
        layout.padding.top.px = 5;
        layout.padding.bottom.px = 10;
        layout.gap.px = 5;

        widget.layout = layout;

        assert.equal(5., child1.top.px);
        assert.equal(5. + 100 + 5, child2.top.px);
    }


    @test
    public function arrangeChildren_verticalOrientationBottomAlign_childrenArrangedCorrectly () : Void
    {
        var widget = new Widget();
        var child1 = widget.addChild(new Widget());
        var child2 = widget.addChild(new Widget());

        child1.height.px = 100;
        child2.height.px = 70;

        var layout = new LineLayout();
        layout.autoSize.set(true, true);
        layout.align.vertical = Bottom;
        layout.orientation = Vertical;
        layout.padding.top.px = 5;
        layout.padding.bottom.px = 10;
        layout.gap.px = 5;

        widget.layout = layout;

        assert.equal(10. + 5 + 70, child1.bottom.px);
        assert.equal(10., child2.bottom.px);
    }


    @test
    public function arrangeChildren_verticalOrientationMiddleAlign_childrenArrangedCorrectly () : Void
    {
        var widget = new Widget();
        var child1 = widget.addChild(new Widget());
        var child2 = widget.addChild(new Widget());

        child1.height.px = 100;
        child2.height.px = 70;
        widget.height.px = 200;

        var layout = new LineLayout();
        layout.autoSize.set(false, false);
        layout.align.vertical = Middle;
        layout.orientation = Vertical;
        layout.gap.px = 5;

        widget.layout = layout;

        var firstPos = 0.5 * (200 - 100 - 70 - 5);
        assert.equal(firstPos, child1.top.px);
        assert.equal(firstPos + 5 + 100, child2.top.px);
    }


    @test
    public function arrangeChildren_horizontalOrientationTopAlign_childrenArrangedCorrectly () : Void
    {
        var widget = new Widget();
        var child1 = widget.addChild(new Widget());
        var child2 = widget.addChild(new Widget());

        child1.height.px = 100;
        child2.height.px = 70;

        var layout = new LineLayout();
        layout.autoSize.set(true, true);
        layout.align.vertical = Top;
        layout.orientation = Horizontal;
        layout.padding.top.px = 5;

        widget.layout = layout;

        assert.equal(5., child1.top.px);
        assert.equal(5., child2.top.px);
    }


    @test
    public function arrangeChildren_horizontalOrientationBottomAlign_childrenArrangedCorrectly () : Void
    {
        var widget = new Widget();
        var child1 = widget.addChild(new Widget());
        var child2 = widget.addChild(new Widget());

        child1.height.px = 100;
        child2.height.px = 70;

        var layout = new LineLayout();
        layout.autoSize.set(true, true);
        layout.align.vertical = Bottom;
        layout.orientation = Horizontal;
        layout.padding.bottom.px = 5;

        widget.layout = layout;

        assert.equal(5., child1.bottom.px);
        assert.equal(5., child2.bottom.px);
    }


    @test
    public function arrangeChildren_horizontalOrientationMiddleAlign_childrenArrangedCorrectly () : Void
    {
        var widget = new Widget();
        var child1 = widget.addChild(new Widget());
        var child2 = widget.addChild(new Widget());

        child1.height.px = 100;
        child2.height.px = 70;

        var layout = new LineLayout();
        layout.autoSize.set(true, true);
        layout.align.vertical = Middle;
        layout.orientation = Horizontal;
        layout.padding.top.px = 5;
        layout.padding.bottom.px = 10;

        widget.layout = layout;

        var middle = (5 + 10 + 100) * 0.5;
        assert.equal(middle - 50, child1.top.px);
        assert.equal(middle - 35, child2.top.px);
    }


}//class LineLayoutTest