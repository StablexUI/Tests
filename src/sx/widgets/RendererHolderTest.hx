package sx.widgets;

import hunit.TestCase;
import sx.backend.Renderer;
import sx.geom.Unit;
import sx.widgets.RendererHolder;



/**
 * sx.widgets.RendererHolder
 *
 */
class RendererHolderTest extends TestCase
{

    @test
    public function autoSize_autoSizeIsTrueRendererResized_widgetResized () : Void
    {
        var renderer = mock(Renderer).create();
        var rendererResized = null;
        stub(renderer).onResize().implement(function (callback) rendererResized = callback);

        var holder = new TestingRendererHolder(renderer);
        holder.autoSize.set(true);

        //simulate callback invokation by renderer
        rendererResized(100, 200);

        assert.equal(Pixel, holder.width.units);
        assert.equal(Pixel, holder.height.units);
        assert.equal(100., holder.width.px);
        assert.equal(200., holder.height.px);
    }


    @test
    public function autoSize_autoSizeIsFalseRendererResized_rendererOnResizeListenerIsDisabled () : Void
    {
        var renderer = mock(Renderer).create();
        var rendererResized = null;
        stub(renderer).onResize().implement(function (callback) rendererResized = callback);

        var holder = new TestingRendererHolder(renderer);
        holder.autoSize.set(false);

        assert.isNull(rendererResized);
    }


    @test
    public function autoSize_autoSizeIsFalseChangedToTrue_widgetResized () : Void
    {
        var renderer = mock(Renderer).create();
        stub(renderer).getWidth().returns(100);
        stub(renderer).getHeight().returns(200);
        var holder = new TestingRendererHolder(renderer);

        holder.autoSize.set(true);

        assert.equal(100., holder.width.px);
        assert.equal(200., holder.height.px);
    }


    @test
    public function autoSize_onlyWidthIsTrueRendererResized_onlyWidgetWidthChanged () : Void
    {
        var renderer = mock(Renderer).create();
        stub(renderer).getWidth().returns(100);
        stub(renderer).getHeight().returns(200);
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
        stub(renderer).getWidth().returns(100);
        stub(renderer).getHeight().returns(200);
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
    public function width_setWidthDirectly_changesAutoSizeWidthToFalse () : Void
    {
        var holder = new TestingRendererHolder(mock(Renderer).create());
        holder.autoSize.width = true;

        holder.width.px = 100;

        assert.isFalse(holder.autoSize.width);
    }


    @test
    public function height_setHeightDirectly_changesAutoSizeHeightToFalse () : Void
    {
        var holder = new TestingRendererHolder(mock(Renderer).create());
        holder.autoSize.height = true;

        holder.height.px = 100;

        assert.isFalse(holder.autoSize.height);
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