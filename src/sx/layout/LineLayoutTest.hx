package sx.layout;

import sx.properties.VerticalAlign;
import sx.properties.HorizontalAlign;
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
        layout.autoSize.set(true);
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
        layout.autoSize.set(true);
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
        layout.autoSize.set(false);
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
        layout.autoSize.set(true);
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
        layout.autoSize.set(true);
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
        layout.autoSize.set(true);
        layout.align.horizontal = Center;
        layout.orientation = Vertical;
        layout.padding.left.px = 5;
        layout.padding.right.px = 10;

        widget.layout = layout;

        var middle = (5 + 10 + 100) * 0.5;
        assert.equal(middle - 50, child1.left.px);
        assert.equal(middle - 35, child2.left.px);
    }


}//class LineLayoutTest