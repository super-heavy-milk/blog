# list recipies
default:
    @just --list

# run a hot reload dev server
dev:
    hugo server -D 

# create a new blog entry e.g. 'my-post.md'
new entry:
    hugo new content "{{ justfile_directory() }}/content/posts/{{ entry }}"
