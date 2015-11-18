package sx.widgets.base;

import sx.TestCase;
import sx.properties.metric.Units;
import sx.backend.Renderer;
import sx.widgets.base.RendererHolder;



/**
 * sx.widgets.base.RendererHolder
 *
 */
class RendererHolderTest extends TestCase
{
    @test
    public function constructor_rendererHasInitialSize_setHolderInitialSize () : Void
    {
        var renderer = mock(Renderer).create();
        stub(renderer).getWidth().returns(100);
        stub(renderer).getHeight().returns(200);

        var holder = new TestingRendererHolder(renderer);

        assert.equal(100., holder.width.px);
        assert.equal(200., holder.height.px);
    }


    @test
    public function autoSize_autoSizeIsTrueRendererResized_widgetResized () : Void
    {
        var renderer = mock(Renderer).create();
        var rendererResized = null;
        stub(renderer).getWidth().returns(100);
        stub(renderer).getHeight().returns(200);
        stub(renderer).onResize().implement(function (callback) rendererResized = callback);

        var holder = new TestingRendererHolder(renderer);
        holder.padding.px = 10;
        holder.autoSize.set(true, true);

        //simulate callback invokation by renderer
        rendererResized(renderer.getWidth(), renderer.getHeight());

        assert.equal(Pixel, holder.width.units);
        assert.equal(Pixel, holder.height.units);
        assert.equal(120., holder.width.px);
        assert.equal(220., holder.height.px);
    }


    @test
    public function autoSize_autoSizeIsFalseRendererResized_rendererOnResizeListenerIsDisabled () : Void
    {
        var renderer = mock(Renderer).create();
        var rendererResized = null;
        stub(renderer).onResize().implement(function (callback) rendererResized = callback);

        var holder = new TestingRendererHolder(renderer);
        holder.autoSize.set(false, false);

        assert.isNull(rendererResized);
    }


    @test
    public function autoSize_autoSizeIsFalseChangedToTrue_widgetResized () : Void
    {
        var renderer = mock(Renderer).create();
        stub(renderer).getWidth().returns(100);
        stub(renderer).getHeight().returns(200);
        var holder = new TestingRendererHolder(renderer);

        holder.autoSize.set(true, true);

        assert.equal(100., holder.width.px);
        assert.equal(200., holder.height.px);
    }


    @test
    public function autoSize_onlyWidthIsTrueRendererResized_onlyWidgetWidthChanged () : Void
    {
        var renderer = mock(Renderer).create();
        var rendererResized = null;
        stub(renderer).onResize().implement(function (callback) rendererResized = callback);

        var holder = new TestingRendererHolder(renderer);
        holder.autoSize.width  = true;
        holder.autoSize.height = false;

        //simulate callback invokation by renderer
        rendererResized(100, 200);

        assert.equal(100., holder.width.px);
        assert.equal(0., holder.height.px);
    }


    @test
    public function autoSize_onlyHeightIsTrueRendererResized_onlyWidgetHeightChanged () : Void
    {
        var renderer = mock(Renderer).create();
        var rendererResized = null;
        stub(renderer).onResize().implement(function (callback) rendererResized = callback);

        var holder = new TestingRendererHolder(renderer);
        holder.autoSize.width  = false;
        holder.autoSize.height = true;

        //simulate callback invokation by renderer
        rendererResized(100, 200);

        assert.equal(0., holder.width.px);
        assert.equal(200., holder.height.px);
    }


    @test
    public function autoSize_changedToFalse_invokesRendererSetAvailableArea () : Void
    {
        var renderer = mock(Renderer).create();
        stub(renderer).getWidth().returns(100);
        stub(renderer).getHeight().returns(50);
        var holder = new TestingRendererHolder(renderer);

        expect(renderer).setAvailableAreaWidth(100.).once();
        expect(renderer).setAvailableAreaHeight(50.).once();

        holder.autoSize.set(false, false);
    }


    @test
    public function width_setWidthDirectly_changesAutoSizeWidthToFalse () : Void
    {
        var holder = new TestingRendererHolder(mock(Renderer).create());
        holder.autoSize.width = true;

        holder.width.px = 100;

        assert.isFalse(holder.autoSize.width);
    }


    @test
    public function width_setWidthDirectly_invokesRendererSetAvailableAreaWidth () : Void
    {
        var renderer = mock(Renderer).create();
        var holder = new TestingRendererHolder(renderer);
        holder.padding.horizontal.px = 10;

        expect(renderer).setAvailableAreaWidth(match.equal(80.)).once();

        holder.width.px = 100;
    }


    @test
    public function height_setHeightDirectly_changesAutoSizeHeightToFalse () : Void
    {
        var holder = new TestingRendererHolder(mock(Renderer).create());
        holder.autoSize.height = true;

        holder.height.px = 100;

        assert.isFalse(holder.autoSize.height);
    }


    @test
    public function height_setHeightDirectly_invokesRendererSetAvailableAreaHeight () : Void
    {
        var renderer = mock(Renderer).create();
        var holder = new TestingRendererHolder(renderer);
        holder.padding.vertical.px = 10;

        expect(renderer).setAvailableAreaHeight(match.equal(80.)).once();

        holder.height.px = 100;
    }


    @test
    public function paddingHorizontal_changedWhileAutoSizeWidthIsFalse_invokesRendererSetAvailableAreaWidth () : Void
    {
        var renderer = mock(Renderer).create();
        var holder = new TestingRendererHolder(renderer);
        holder.autoSize.width = false;
        holder.width.px = 100;

        expect(renderer).setAvailableAreaWidth(match.equal(80.)).once();

        holder.padding.horizontal.px = 10;
    }


    @test
    public function paddingVertical_changedWhileAutoSizeHeightIsFalse_invokesRendererSetAvailableAreaHeight () : Void
    {
        var renderer = mock(Renderer).create();
        var holder = new TestingRendererHolder(renderer);
        holder.autoSize.height = false;
        holder.height.px = 100;

        expect(renderer).setAvailableAreaHeight(match.equal(80.)).once();

        holder.padding.vertical.px = 10;
    }


    @test
    public function paddingHorizontal_changedWhileAutoSizeWidthIsTrue_dispatchesOnResizeSignalWithHolderWidth () : Void
    {
        var dispatched = 0;
        var renderer = mock(Renderer).create();
        stub(renderer).getWidth().returns(100);
        var holder = new TestingRendererHolder(renderer);
        holder.autoSize.width = true;
        holder.onResize.add(function(w, s, u, v) {
            if (s == holder.width) dispatched ++;
        });

        holder.padding.horizontal.px = 10;

        assert.equal(1, dispatched);
        assert.equal(120., holder.width.px);
    }


    @test
    public function paddingVertical_changedWhileAutoSizeHeightIsTrue_dispatchesOnResizeSignalWithHolderHeight () : Void
    {
        var dispatched = 0;
        var renderer = mock(Renderer).create();
        stub(renderer).getHeight().returns(100);
        var holder = new TestingRendererHolder(renderer);
        holder.autoSize.height = true;
        holder.onResize.add(function(w, s, u, v) {
            if (s == holder.height) dispatched ++;
        });

        holder.padding.vertical.px = 10;

        assert.equal(1, dispatched);
        assert.equal(120., holder.height.px);
    }


    @test
    public function padding_setToPercentWhileAutoSizeIsTrue_holderSizeAndPaddingCalculatedCorrectly () : Void
    {
        var renderer = mock(Renderer).create();
        stub(renderer).getWidth().returns(800);
        stub(renderer).getHeight().returns(40);
        var holder = new TestingRendererHolder(renderer);
        holder.autoSize.set(true, true);

        holder.padding.pct = 10;

        assert.equal(1000., holder.width.px);
        assert.equal(50., holder.height.px);
        assert.equal(100., holder.padding.left.px);
        assert.equal(100., holder.padding.right.px);
        assert.equal(5., holder.padding.top.px);
        assert.equal(5., holder.padding.bottom.px);
    }


}//class RendererHolderTest



private class TestingRendererHolder extends RendererHolder
{
    private var testRenderer : Renderer;

    public function new (renderer:Renderer) : Void
    {
        testRenderer = renderer;
        super();
    }

    override private function get___renderer () return testRenderer;

}//class TestingRendererHolder