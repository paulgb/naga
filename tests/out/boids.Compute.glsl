#version 310 es

precision highp float;

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct Particle {
    vec2 pos;
    vec2 vel;
};

uniform SimParams_block_0 {
    float deltaT;
    float rule1Distance;
    float rule2Distance;
    float rule3Distance;
    float rule1Scale;
    float rule2Scale;
    float rule3Scale;
} _group_0_binding_0;

readonly buffer Particles_block_1 {
    Particle particles[];
} _group_0_binding_1;

buffer Particles_block_2 {
    Particle particles[];
} _group_0_binding_2;


void main() {
    uvec3 global_invocation_id = gl_GlobalInvocationID;
    vec2 vPos;
    vec2 vVel;
    vec2 cMass;
    vec2 cVel;
    vec2 colVel;
    int cMassCount = 0;
    int cVelCount = 0;
    vec2 pos1;
    vec2 vel1;
    uint i = 0u;
    if((global_invocation_id.x >= 1500u)) {
        return;
    }
    vPos = _group_0_binding_1.particles[global_invocation_id.x].pos;
    vVel = _group_0_binding_1.particles[global_invocation_id.x].vel;
    cMass = vec2(0.0, 0.0);
    cVel = vec2(0.0, 0.0);
    colVel = vec2(0.0, 0.0);
    while(true) {
        uint _expr37 = i;
        if((_expr37 >= 1500u)) {
            break;
        }
        uint _expr39 = i;
        if((_expr39 == global_invocation_id.x)) {
            continue;
        }
        uint _expr42 = i;
        pos1 = _group_0_binding_1.particles[_expr42].pos;
        uint _expr47 = i;
        vel1 = _group_0_binding_1.particles[_expr47].vel;
        vec2 _expr51 = pos1;
        vec2 _expr52 = vPos;
        if((distance(_expr51, _expr52) < _group_0_binding_0.rule1Distance)) {
            vec2 _expr57 = cMass;
            vec2 _expr58 = pos1;
            cMass = (_expr57 + _expr58);
            int _expr60 = cMassCount;
            cMassCount = (_expr60 + 1);
        }
        vec2 _expr63 = pos1;
        vec2 _expr64 = vPos;
        if((distance(_expr63, _expr64) < _group_0_binding_0.rule2Distance)) {
            vec2 _expr69 = colVel;
            vec2 _expr70 = pos1;
            vec2 _expr71 = vPos;
            colVel = (_expr69 - (_expr70 - _expr71));
        }
        vec2 _expr74 = pos1;
        vec2 _expr75 = vPos;
        if((distance(_expr74, _expr75) < _group_0_binding_0.rule3Distance)) {
            vec2 _expr80 = cVel;
            vec2 _expr81 = vel1;
            cVel = (_expr80 + _expr81);
            int _expr83 = cVelCount;
            cVelCount = (_expr83 + 1);
        }
        uint _expr86 = i;
        i = (_expr86 + 1u);
    }
    int _expr89 = cMassCount;
    if((_expr89 > 0)) {
        vec2 _expr92 = cMass;
        int _expr93 = cMassCount;
        vec2 _expr97 = vPos;
        cMass = ((_expr92 / vec2(float(_expr93))) - _expr97);
    }
    int _expr99 = cVelCount;
    if((_expr99 > 0)) {
        vec2 _expr102 = cVel;
        int _expr103 = cVelCount;
        cVel = (_expr102 / vec2(float(_expr103)));
    }
    vec2 _expr107 = vVel;
    vec2 _expr108 = cMass;
    vec2 _expr113 = colVel;
    vec2 _expr118 = cVel;
    vVel = (((_expr107 + (_expr108 * _group_0_binding_0.rule1Scale)) + (_expr113 * _group_0_binding_0.rule2Scale)) + (_expr118 * _group_0_binding_0.rule3Scale));
    vec2 _expr123 = vVel;
    vec2 _expr125 = vVel;
    vVel = (normalize(_expr123) * clamp(length(_expr125), 0.0, 0.1));
    vec2 _expr131 = vPos;
    vec2 _expr132 = vVel;
    vPos = (_expr131 + (_expr132 * _group_0_binding_0.deltaT));
    vec2 _expr137 = vPos;
    if((_expr137.x < -1.0)) {
        vPos.x = 1.0;
    }
    vec2 _expr143 = vPos;
    if((_expr143.x > 1.0)) {
        vPos.x = -1.0;
    }
    vec2 _expr149 = vPos;
    if((_expr149.y < -1.0)) {
        vPos.y = 1.0;
    }
    vec2 _expr155 = vPos;
    if((_expr155.y > 1.0)) {
        vPos.y = -1.0;
    }
    vec2 _expr164 = vPos;
    _group_0_binding_2.particles[global_invocation_id.x].pos = _expr164;
    vec2 _expr168 = vVel;
    _group_0_binding_2.particles[global_invocation_id.x].vel = _expr168;
    return;
}

