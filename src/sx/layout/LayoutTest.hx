package sx.layout;

import sx.TestCase;
import sx.layout.Layout;
import sx.widgets.Widget;



/**
 * sx.layout.Layout
 *
 */
@:access(sx.layout.Layout.usedBy)
@:access(sx.layout.Layout.removed)
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
    public function usedBy_notInitializedWidget_doesNotArrangeChildren () : Void
    {
        var layout = mock(Layout).create();
        var widget = new Widget();

        expect(layout).arrangeChildren().never();

        layout.usedBy(widget);
    }


    @test
    public function usedBy_notInitializedWidget_arrangeChildrenOnWidgetInitialization () : Void
    {
        var layout = mock(Layout).create();
        var widget = new Widget();
        layout.usedBy(widget);

        expect(layout).arrangeChildren().once();

        widget.initialize();
    }


    @test
    public function usedBy_initializedWidget_invokesArrangeChildren () : Void
    {
        var layout = mock(Layout).create();
        var widget = new Widget();
        widget.initialize();

        expect(layout).arrangeChildren().once();

        layout.usedBy(widget);
    }


    @test
    public function widget_resized_arrangeChildrenCalled () : Void
    {
        var widget = new Widget();
        var layout = mock(Layout).create();
        widget.initialize();
        widget.layout = layout;

        expect(layout).arrangeChildren().exactly(2);

        widget.width.px = 100;
        widget.height.px = 200;
    }


}//class LayoutTest