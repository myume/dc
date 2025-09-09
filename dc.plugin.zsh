function dc() {
    local dc_executable="/home/myu/infinite/projects/dc/target/debug/dc"

    if [ ! -f "$dc_executable" ]; then
        echo "Error: dc executable not found at $dc_executable"
        return 1
    fi

    local target_dir
    target_dir=$("$dc_executable" "$@")

    if [ -n "$target_dir" ]; then
        cd "$target_dir"
    fi
}
