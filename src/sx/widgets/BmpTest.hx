package sx.widgets;

import hunit.TestCase;
import sx.backend.BitmapRenderer;
import sx.widgets.Bmp;



/**
 * sx.widgets.Bmp
 *
 */
class BmpTest extends TestCase
{

    @test
    public function bitmapData_changed_invokesRendererSetBitmapData () : Void
    {
        var bmp = mock(Bmp).create();
        var renderer = mock(BitmapRenderer).create(bmp);
        modify(bmp).renderer = renderer;

        expect(renderer).setBitmapData(match.equal(null)).once();

        bmp.bitmapData = null;
    }


    @test
    public function autoSize_setBothTrue_invokesRendererSetScaleWidthCorrectArgs () : Void
    {
        var bmp = mock(Bmp).create();
        var renderer = mock(BitmapRenderer).create(bmp);
        stub(renderer).getBitmapDataWidth().returns(10.);
        stub(renderer).getBitmapDataHeight().returns(10.);
        modify(bmp).renderer = renderer;

        expect(renderer).setScale(1., 1.).once();

        bmp.autoSize.set(true);
    }


    @test
    public function autoSize_setWidthTrueWhileHeightFalseAndKeepAspectTrue_invokesRendererSetScaleWidthCorrectArgs () : Void
    {
        var bmp = mock(Bmp).create();
        var renderer = mock(BitmapRenderer).create(bmp);
        stub(renderer).getBitmapDataWidth().returns(10.);
        stub(renderer).getBitmapDataHeight().returns(20.);
        modify(bmp).renderer = renderer;
        bmp.autoSize.height  = false;
        bmp.keepAspect       = true;

        expect(renderer).setScale(1., 1.).once();

        bmp.autoSize.width = true;
    }


    @test
    public function autoSize_setHeightTrueWhileWidthFalseAndKeepAspectTrue_invokesRendererSetScaleWidthCorrectArgs () : Void
    {
        var bmp = mock(Bmp).create();
        var renderer = mock(BitmapRenderer).create(bmp);
        stub(renderer).getBitmapDataWidth().returns(10.);
        stub(renderer).getBitmapDataHeight().returns(20.);
        modify(bmp).renderer = renderer;
        bmp.autoSize.width  = false;
        bmp.keepAspect       = true;

        expect(renderer).setScale(1., 1.).once();

        bmp.autoSize.height = true;
    }


    @test
    public function autoSize_setBothFalseWhileKeepAspectFalse_invokesRendererSetScaleWidthCorrectArgs () : Void
    {
        var bmp = mock(Bmp).create();
        var renderer = mock(BitmapRenderer).create(bmp);
        stub(renderer).getBitmapDataWidth().returns(10.);
        stub(renderer).getBitmapDataHeight().returns(10.);
        modify(bmp).renderer = renderer;
        bmp.width.px   = 30;
        bmp.height.px  = 40;
        bmp.padding.px = 5;
        bmp.keepAspect = false;

        expect(renderer).setScale(2., 3.).once();

        bmp.autoSize.set(false);
    }


}//class BmpTest