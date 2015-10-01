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

}//class LayoutTest