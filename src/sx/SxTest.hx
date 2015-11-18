package sx;

import sx.TestCase;
import sx.skins.Skin;
import sx.widgets.Widget;



/**
 * sx.Sx
 *
 */
class SxTest extends TestCase
{

    @test
    public function skin_requestdSkinIsNotRegistered_returnsNull () : Void
    {
        Sx.dropSkins();

        var skin = Sx.skin('neverRegisteredSkin' + Math.random());

        assert.isNull(skin);
    }


    @test
    public function skin_skinFactoryRegistered_returnsSkinInstance () : Void
    {
        var name = 'test';
        var factory = function () {
            return new Skin();
        }
        Sx.registerSkin(name, factory);

        var skin = Sx.skin(name);

        assert.notNull(skin);
    }


    @test
    public function root_noCustomRoot_returnsRootByBackendManager () : Void
    {
        var defaultRoot = Sx.backendManager.getRoot();

        var currentRoot = Sx.root;

        assert.equal(defaultRoot, currentRoot);
    }


    @test
    public function root_customRootSpecified_returnsCustomRoot () : Void
    {
        var customRoot = new Widget();
        Sx.root = customRoot;

        var currentRoot = Sx.root;

        assert.equal(customRoot, currentRoot);
    }

}//class SxTest