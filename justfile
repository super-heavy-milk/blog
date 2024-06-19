# list recipes
default:
    @just --list

# run a hot reload dev server
dev:
    hugo server -D --navigateToChanged

# run a hot reload preview of what the live site will look like
preview:
    hugo server --navigateToChanged

# create a new blog entry e.g. 'my-post.md'
blog entry:
    hugo new content "{{ justfile_directory() }}/content/posts/{{ entry }}"

# run all the pre-commit hooks
lint:
    pre-commit run --all-files --hook-stage manual

# format the justfile
fmt-justfile:
    just --fmt --unstable

# resize an image e.g. 'just resize input_image.jpeg output_image.jpeg 100'
resize input output resize_percent:
    magick -verbose \
        '{{ justfile_directory() }}/static/{{ input }}' \
        -filter LanczosSharp \
        -distort Resize {{ resize_percent }}% \
        '{{ justfile_directory() }}/static/{{ output }}'
