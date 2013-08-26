aspect = argument0 / argument1;

if (argument2 / aspect > argument3) {
    window_set_rectangle(
        argument0/2 - (argument3 * aspect)/2,
        argument1/2 - argument3/2,
        argument3 * aspect, argument3
    );
} else {
    window_set_rectangle(
        argument0/2 - argument2/2,
        argument1/2 - (argument2 / aspect)/2,
        argument2, argument2 / aspect
    );
}

