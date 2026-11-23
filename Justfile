set ignore-comments := true

# Preview using Vim's bundled runtime followed by this add-on.
[no-cd]
preview-vim *ARGS:
    vim -N -u NORC -i NONE \
        --cmd {{ quote('let &runtimepath = ' + '"' + justfile_directory() + '," . &runtimepath . ",' + justfile_directory() + '/after"') }} \
        -c 'filetype plugin indent on | syntax enable | filetype detect' \
        {{ ARGS }}
