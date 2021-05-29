#version 310 es

precision highp float;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

buffer IOData_block_0 {
    float data;
} _group_0_binding_0;


void main() {
    float a = 0.0;
    float _expr3 = a;
    a = 1.0;
    _group_0_binding_0.data = _expr3;
    return;
}

