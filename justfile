# list recipies
default:
    @just --list

# run a hot reload dev server
dev:
    hugo server -D 

# create a new blog entry e.g. 'posts/my-post.md'
new entry:
    hugo new content "{{ justfile_directory() }}/content/{{ entry }}"

# run all the pre-commit hooks
lint:
    pre-commit run --all-files --hook-stage manual

# format the justfile
fmt-justfile:
    just --fmt --unstable
