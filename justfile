# list recipies
default:
    @just --list

# run a hot reload dev server
dev:
    hugo server -D --navigateToChanged

# run a hot reload preivew of what the live site will look like
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
