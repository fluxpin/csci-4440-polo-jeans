precision mediump float;

uniform sampler2D tex;
varying vec2 v_tex_coord;

void main(void)
{
        gl_FragColor = texture2D(tex, v_tex_coord);
}
