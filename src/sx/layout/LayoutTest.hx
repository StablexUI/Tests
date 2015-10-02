package sx.layout;

import hunit.TestCase;
import sx.layout.Layout;
import sx.widgets.Widget;



/**
 * sx.layout.Layout
 *
 */
class LayoutTest extends TestCase
{

    @test
    public function usedBy_layoutAlreadyUsedByAnotherWidget_layoutRemovedFromAnotherWidget () : Void
    {
        var widget = new Widget();
        var layout = new Layout();
        widget.layout = layout;

        layout.usedBy(new Widget());

        assert.isNull(widget.layout);
    }


    @test
    public function usedBy_always_invokesArrangeChildren () : Void
    {
        var layout = mock(Layout).create();

        expect(layout).arrangeChildren().once();

        layout.usedBy(new Widget());
    }


    @test
    public function widget_resized_arrangeChildrenCalled () : Void
    {
        var widget = new Widget();
        var layout = mock(Layout).create();
        widget.layout = layout;

        expect(layout).arrangeChildren().exactly(2);

        widget.width.px = 100;
        widget.height.px = 200;
    }


}//class LayoutTest