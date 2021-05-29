[[block]]
struct IOData {
    data: f32;
};

[[group(0), binding(0)]]
var<storage> v_data: [[access(read_write)]] IOData;

[[stage(compute), workgroup_size(1, 1, 1)]]
fn main() {
    var a: f32 = 0.0;

    let _e3: f32 = a;
    a = 1.0;
    v_data.data = _e3;
    return;
}
