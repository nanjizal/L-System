package;
import luxe.Input;
import luxe.Vector;
import lsystem.*;
import phoenix.geometry.Geometry;
import luxe.Color;
import drawings.*;
import khaMath.Vector2;
import luxe.Vector;
import target.BasicColors;
//  All axioms and rules used as examples below come from the wikipedia page for L-Systems 
//  ( http://en.wikipedia.org/wiki/L-system ).
//  plantD, plantE, plantF from 1990 book Algorithmic Beauty of Plants.
//  another source http://www.kevs3d.co.uk/dev/lsystems/
class Animation extends luxe.Game {
    var currentColor: Color;
    var graphics: Array<Geometry>;
    var drawing: Drawing;
    var drawings: Array<Drawing>;
    var colors: Array<Color>;
    override function ready() {
        //darkRed = new Color( 0.5, 0.2, 0.2, 1 );
        currentColor = BasicColors.Red;
        graphics = new Array<phoenix.geometry.Geometry>();
        colors =   [    BasicColors.Red
                    ,   BasicColors.Green
                    ,   BasicColors.Blue
                    ,   BasicColors.Red
                    ,   BasicColors.Green
                    ,   BasicColors.Green
                    ,   BasicColors.Red
                    ,   BasicColors.Green
                    ,   BasicColors.Yellow
                    ,   BasicColors.Red
                    ,   BasicColors.Grey ];
        drawings = [    new PenoTriangle( 7, 4.5, position( 700, 600), line )
                    ,   new FunnyTriangle( 6, 10, position( 100, 600 ), line )
                    ,   new Tiles( 5, 20, centre(), line )
                    ,   new Seaweed( 5, 1, position( 550, 600 ), line, setColor.bind( 3 ) )
                    ,   new PondWeed( 5, 5, position( 750, 600 ), line, setColor.bind( 4 ) )
                    ,   new SierpinskiSnowFlake( 4, 2, position( 500, 200 ), line )
                    ,   new Plant( 4, 4, position( 90, 600 ), line )
                    ,   new PlantE( 7, 1, position( 800, 300 ), line )
                    ,   new PlantD( 7, 1, position( 400, 400 ), line )
                    ,   new DragonCurve( 10, 10, topLeft(), line )
                    ,   new SierpinskiTriangle( 8, 2, bottomRight(), line )
        ];
    }
    inline public function setColor( count: Int, col: Color ){
        colors[ count ] = col;
    }
    public function clear():Void {
        var geom;
        while ((geom = graphics.pop()) != null) geom.drop();
    }
    inline function position( x: Float, y: Float ): Vector2 {
        return new Vector2( x, y );
    }
    inline function centre():Vector2 {
        return new Vector2( Luxe.screen.w / 2, Luxe.screen.h / 2 );
    }
    inline function bottomRight():Vector2{
        return new Vector2( Luxe.screen.w - 50, Luxe.screen.h - 50 );
    }
    inline function topLeft():Vector2{
        return new Vector2( 80, 170 );
    }
    inline function line( line ){
        var start: LNode = line.start;
        var end: LNode = line.end;
        var geom = Luxe.draw.line({
            p0 : new Vector( start.pos.x, start.pos.y ),
            p1 : new Vector( end.pos.x, end.pos.y ),
            color : currentColor
        });
        graphics[ graphics.length ] = geom;
    }
    override function onkeyup( e: KeyEvent ){
        if( e.keycode == Key.escape ) Luxe.shutdown();
    }
    var time: Int = 0;
    var speed: Int = 100;
    override function update( dt: Float ){
        if( time == 1000 ) {
            speed = 10;
            clear();
        }
        for( i in 0...speed ){
            var j = 0;
            for( drawing in drawings ){
                if( time > 1000 || ( j == 3 || j == 4 ) ){
                    currentColor = colors[ j ];
                    if( drawing.hasNext() ){
                        drawing.draw();
                    } else {}
                }
                j++;
            }
        }
        time++;
    }
}
