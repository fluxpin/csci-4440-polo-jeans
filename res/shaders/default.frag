precision mediump float;

uniform sampler2D tex;
varying vec2 v_tex_coord;

void main(void)
{
        vec4 texel = texture2D(tex, v_tex_coord);
        if (texel.a < 0.5)
                discard;
        gl_FragColor = texel;
}
