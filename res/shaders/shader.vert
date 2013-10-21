uniform mat4 p_matrix, mv_matrix;
attribute vec2 vertex;
attribute vec2 a_tex_coord;
varying vec2 v_tex_coord;

void main(void)
{
        gl_Position = p_matrix * mv_matrix * vec4(vertex, 0.0, 1.0);
        v_tex_coord = a_tex_coord;
}
