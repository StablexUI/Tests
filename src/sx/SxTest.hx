package sx;

import hunit.TestCase;
import sx.skins.Skin;



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

}//class SxTest